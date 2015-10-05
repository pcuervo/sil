class AddCodeUrlToInventoryItems < ActiveRecord::Migration
  def change
    add_column :inventory_items, :code_url, :string, :default => 'nocode.png'
  end
end
