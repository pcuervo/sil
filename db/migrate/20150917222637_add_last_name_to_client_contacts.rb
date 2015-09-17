class AddLastNameToClientContacts < ActiveRecord::Migration
  def change
    add_column :client_contacts, :last_name, :string
  end
end
