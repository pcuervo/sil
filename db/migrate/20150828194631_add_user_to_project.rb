class AddUserToProject < ActiveRecord::Migration
  def change
    add_column :projects, :user_id, :integer, :default => 1
    add_index :projects, :user_id
  end
end
