class Project < ActiveRecord::Base
  validates :litobel_id, uniqueness: true
  validates :name, :litobel_id, :client, presence: true

  has_and_belongs_to_many :users
  belongs_to :client

end
