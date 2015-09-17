class CreateClientContacts < ActiveRecord::Migration
  def change
    create_table :client_contacts do |t|
      t.string :name,         null: false
      t.string :phone
      t.string :phone_ext,    default: "-"
      t.string :email,        null: false
      t.string :business_unit
      t.references :client,   index: true

      t.timestamps null: false
    end
    add_foreign_key :client_contacts, :clients
  end
end
