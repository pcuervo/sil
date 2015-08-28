class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :sys_module
      t.string :action
      t.integer :concept

      t.timestamps null: false
    end
    add_index :logs, :user_id
  end
end
