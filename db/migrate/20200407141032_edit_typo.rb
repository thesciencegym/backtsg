class EditTypo < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :discription, :description
  end
end
