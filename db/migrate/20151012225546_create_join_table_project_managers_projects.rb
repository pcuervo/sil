class CreateJoinTableProjectManagersProjects < ActiveRecord::Migration
  def change
    create_table :managers_projects, id: false do |t|
      t.integer :user_id
      t.integer :project_id
    end
  end
end
