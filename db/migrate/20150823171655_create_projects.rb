class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string      :name,        default: "empty"
      t.string      :litobel_id,  default: "-" 
      t.references  :user,       index: true
      t.timestamps
    end
    add_foreign_key :projects, :users
  end
end
