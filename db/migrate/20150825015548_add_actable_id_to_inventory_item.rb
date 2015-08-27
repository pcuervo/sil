class AddActableIdToInventoryItem < ActiveRecord::Migration
  def change
    add_column :inventory_items, :actable_id, :integer
    add_column :inventory_items, :actable_type, :string
  end
end
