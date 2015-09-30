class ClientContactSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :phone_ext, :email, :business_unit, :client_id
end
