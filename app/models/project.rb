class Project < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :litobel_id, uniqueness: true
  validates :name, :litobel_id, presence: true
end
