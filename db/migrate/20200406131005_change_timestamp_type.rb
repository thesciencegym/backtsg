class ChangeTimestampType < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :timestamp_edit, :bigint
  end
end
