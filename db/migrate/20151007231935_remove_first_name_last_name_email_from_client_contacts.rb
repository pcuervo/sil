class RemoveFirstNameLastNameEmailFromClientContacts < ActiveRecord::Migration
  def change
    remove_column :client_contacts, :first_name
    remove_column :client_contacts, :last_name
    remove_column :client_contacts, :email
  end
end
