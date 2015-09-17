class ChangeEmailDefaultToClientContacts < ActiveRecord::Migration
  def change
    change_column_default :client_contacts, :email, ''
  end
end
