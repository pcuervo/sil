class AddActorIdToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :actor_id, :integer
  end
end
