class AddClientRefToInventoryItems < ActiveRecord::Migration
  def change
    add_reference :inventory_items, :client, index: true
    add_foreign_key :inventory_items, :clients
  end
end
