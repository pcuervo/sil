class InventoryItem < ActiveRecord::Base
  validates :name, :user_id, :type, :status, presence: true

  belongs_to :user
end
