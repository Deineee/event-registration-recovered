class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy

  validates :location, :start_date, :end_date, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :status, inclusion: { in: %w[ongoing closed] }
  validate :end_date_after_start_date

  before_save :update_status_based_on_end_date

  # Allowlisted fields for Ransack searching
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      name
      location
      start_date
      end_date
      status
      created_at
      updated_at
      description
      user_id
    ]
  end

  def update_status_if_expired
    if end_date.present? && end_date < Date.today && status != "closed"
      update(status: "closed")
    end
  end

  def update_status_based_on_end_date
    if end_date.present?
      self.status ||= end_date < Date.today ? "closed" : "ongoing"
    end
  end

  after_find :check_and_update_status

  private

  def check_and_update_status
    update_status_if_expired
  end

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
