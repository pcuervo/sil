class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, default: "Empty project"
      t.string :litobel_id, default: "-" 
      t.timestamps null: false
    end
  end
end
