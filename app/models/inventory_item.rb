class InventoryItem < ActiveRecord::Base
  actable

  belongs_to :user

  validates :name, :status, presence: true
  
end
