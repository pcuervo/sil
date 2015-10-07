class InventoryTransaction < ActiveRecord::Base
  belongs_to :inventory_item
  validates :entry_date, :concept, :storage_type, :delivery_company, :inventory_item, presence: true
end
