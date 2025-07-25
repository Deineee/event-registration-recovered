class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy

  validates :location, :start_date, :end_date, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :status, inclusion: { in: %w[not_started ongoing closed] }
  validate :end_date_after_start_date

  before_create :set_status_based_on_dates

  # Allowlisted fields for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id name location start_date end_date status created_at updated_at description user_id]
  end

  def set_status_based_on_dates
    today = Date.today

    if end_date.present? && end_date < today
      self.status = "closed"
    elsif start_date.present? && start_date > today
      self.status = "not_started"
    else
      self.status = "ongoing"
    end
  end

  after_find :check_and_update_status

  private

  def check_and_update_status
    if end_date.present? && end_date < Date.today && status != "closed"
      update_column(:status, "closed")
    end
  end

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
