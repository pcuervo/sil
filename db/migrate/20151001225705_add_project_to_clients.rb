class AddProjectToClients < ActiveRecord::Migration
  def change
    add_reference :clients, :project, index: true
    add_foreign_key :clients, :projects
  end
end
