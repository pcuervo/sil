class AddBarCodeToInventoryItems < ActiveRecord::Migration
  def change
    add_column :inventory_items, :barcode, :string, unique: true
  end
end
