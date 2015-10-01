class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
  has_many :client_contacts
end
