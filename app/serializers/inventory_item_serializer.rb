class InventoryItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :item_type, :actable_type, :created_at

end
