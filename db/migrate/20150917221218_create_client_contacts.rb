class CreateClientContacts < ActiveRecord::Migration
  def change
    create_table :client_contacts do |t|
      t.string      :first_name,    default: "-"
      t.string      :last_name,     default: "-"
      t.string      :phone,         default: "-"
      t.string      :phone_ext,     default: "-"
      t.string      :email,         default: "no@email.com"
      t.string      :business_unit, default: "-"
      t.references  :client,        index: true
      t.timestamps null: false
    end
    add_foreign_key :client_contacts, :clients
  end
end
