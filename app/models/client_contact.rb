class ClientContact < ActiveRecord::Base
  belongs_to :client

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
