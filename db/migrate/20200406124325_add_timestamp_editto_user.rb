class AddTimestampEdittoUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :timestamp_edit, :integer
  end
end
