class RemoveInventoryItemIdFromUnitItem < ActiveRecord::Migration
  def change
    remove_column :unit_items, :inventory_item_id, :integer
  end
end
