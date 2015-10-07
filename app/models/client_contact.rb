class ClientContact < ActiveRecord::Base
  acts_as :user
  belongs_to :client

  validates :first_name, :last_name, :email, :client, presence: true
  validates :email, uniqueness: true
end
