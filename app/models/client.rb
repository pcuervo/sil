class Client < ActiveRecord::Base
  has_many :client_contacts, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
end
