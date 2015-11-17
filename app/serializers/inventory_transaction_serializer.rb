class InventoryTransactionSerializer < ActiveModel::Serializer
  attributes :id, :entry_date, :concept, :storage_type, :delivery_company, :delivery_company_contact, :additional_comments, :created_at, :inventory_item

end
