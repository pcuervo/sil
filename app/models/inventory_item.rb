class InventoryItem < ActiveRecord::Base
  actable
  belongs_to :user

  validates :name, :user_id, :status, presence: true
  
end
