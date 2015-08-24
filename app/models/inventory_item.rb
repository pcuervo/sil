class InventoryItem < ActiveRecord::Base
  validates :name, :user_id, :type, :status, presence: true
end
