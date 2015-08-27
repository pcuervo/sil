class RemoveTypeFromInventoryItem < ActiveRecord::Migration
  def change
    remove_column :inventory_items, :type, :string
  end
end
