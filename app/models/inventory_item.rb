class InventoryItem < ActiveRecord::Base
  actable

  belongs_to :user
  belongs_to :project
  belongs_to :client

  validates :name, :status, :user, :project, :client, presence: true
  
end
