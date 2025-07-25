class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :attendee_name, presence: true, length: { maximum: 100 }
  validates :attendee_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }, length: { maximum: 255 }

   def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      attendee_name
      attendee_email
      event_id
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[event user]
  end
end
