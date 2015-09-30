class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :litobel_id, :created_at, :updated_at
end
