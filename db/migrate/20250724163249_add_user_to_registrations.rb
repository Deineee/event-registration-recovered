class AddUserToRegistrations < ActiveRecord::Migration[8.0]
  def change
    add_reference :registrations, :user, null: false, foreign_key: true
  end
end
