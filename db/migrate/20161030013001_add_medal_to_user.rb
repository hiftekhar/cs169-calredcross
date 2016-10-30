class AddMedalToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :medal, :string
  end
end
