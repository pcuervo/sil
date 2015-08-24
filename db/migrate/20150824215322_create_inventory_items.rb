class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.string :name, default: " "
      t.text :description, default: " "
      t.string :image_url, default: "default_item.png"
      t.string :type, default: "unit"
      t.string :status, default: "active"
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :inventory_items, :user_id
  end
end
