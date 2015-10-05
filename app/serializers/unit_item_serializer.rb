class UnitItemSerializer < ActiveModel::Serializer
  attributes :id, :serial_number, :brand, :model, :name, :description, :image_url, :code_url, :status
  has_one :project
end