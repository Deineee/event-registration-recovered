class AddStatusToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :status, :string, default: "ongoing"
  end
end
