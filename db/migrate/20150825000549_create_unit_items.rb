class CreateUnitItems < ActiveRecord::Migration
  def change
    create_table :unit_items do |t|
      t.string :serial_number, default: " "
      t.string :brand, default: " "
      t.string :model, default: " "
      t.integer :inventory_item_id

      t.timestamps null: false
    end
    add_index :unit_items, :inventory_item_id
  end
end
