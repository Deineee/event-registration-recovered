class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy

  validates :location, :start_date, :end_date, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :status, inclusion: { in: %w[not_started ongoing closed] }
  validate :end_date_after_start_date

  before_save :set_status_based_on_dates

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

  private

  def set_status_based_on_dates
    if start_date.present? && end_date.present?
      today = Date.today

      if today < start_date
        self.status = "not_started"
      elsif today >= start_date && today <= end_date
        self.status = "ongoing"
      else
        self.status = "closed"
      end
    end
  end

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
