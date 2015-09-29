class AddItemTypeAndCodeUrlToInventoryItems < ActiveRecord::Migration
  def change
    add_column :inventory_items, :item_type, :string, default: 'otro'
    add_column :inventory_items, :code_url, :string, default: 'no_code.png'
  end
end
