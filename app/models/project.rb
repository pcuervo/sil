class Project < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :litobel_id, uniqueness: true
  validates :name, :litobel_id, presence: true

  has_and_belongs_to_many :users
end
