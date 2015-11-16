class AddItemTypeToInventoryItems < ActiveRecord::Migration
  def change
    add_column :inventory_items, :item_type, :string
  end
end
