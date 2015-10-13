class CreateJoinTableAccountExecutivesProjects < ActiveRecord::Migration
  def change
    create_table :account_executives_projects, id: false do |t|
      t.integer :user_id
      t.integer :project_id
    end
  end
end
