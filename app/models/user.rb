class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, dependent: :destroy

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= "user"
  end

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end
end
