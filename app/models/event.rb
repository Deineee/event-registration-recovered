class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy

  validates :location, :date, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :status, inclusion: { in: %w[ongoing closed] }
  before_save :update_status_based_on_date

  # Allowlisted fields for Ransack searching
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      name
      location
      date
      status
      created_at
      updated_at
      description
      user_id
    ]
  end

  # Automatically close events past their date
  def update_status_if_expired
    if date.present? && date < Date.today && status != "closed"
      update(status: "closed")
    end
  end

  def update_status_based_on_date
    if date.present?
      self.status ||= date.present? && date < Date.today ? "closed" : "ongoing"
    end
  end
  
  # Auto-close on load
  after_find :check_and_update_status


  private

  def check_and_update_status
    update_status_if_expired
  end
end
