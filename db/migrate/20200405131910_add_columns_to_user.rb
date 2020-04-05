class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :member_id, :integer
    add_column :users, :mobile, :string
    add_column :users, :vg_user_id, :integer
  end
end
