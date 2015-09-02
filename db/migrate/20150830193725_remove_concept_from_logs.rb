class RemoveConceptFromLogs < ActiveRecord::Migration
  def change
    remove_column :logs, :concept, :integer
  end
end
