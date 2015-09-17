class ChangeNameToFirstNameClientContact < ActiveRecord::Migration
  def change
    rename_column :client_contacts, :name, :first_name
  end
end
