class ChangeNameDefaultToClientContacts < ActiveRecord::Migration
  def change
    change_column_default :client_contacts, :first_name, ''
    change_column_default :client_contacts, :last_name, ''
  end
end
