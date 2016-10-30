class AddHoursToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :num_hours, :integer
  end
end
