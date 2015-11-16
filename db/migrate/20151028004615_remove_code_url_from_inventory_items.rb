class RemoveCodeUrlFromInventoryItems < ActiveRecord::Migration
  def change
    remove_column :inventory_items, :code_url, :string
  end
end
