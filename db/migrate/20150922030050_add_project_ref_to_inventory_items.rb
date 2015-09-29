class AddProjectRefToInventoryItems < ActiveRecord::Migration
  def change
    add_reference :inventory_items, :project, index: true
    add_foreign_key :inventory_items, :projects
  end
end
