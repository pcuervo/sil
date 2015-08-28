class User < ActiveRecord::Base
	validates :auth_token, uniqueness: true
  validates :role, inclusion: { in: [1, 2, 3], message: "%{value} is not a valid role" }
  validates :name, :last_name, :email, :role, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 	before_create :generate_authentication_token!
 	
 	def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  has_many :inventory_items
end
