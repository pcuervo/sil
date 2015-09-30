class User < ActiveRecord::Base
  before_create :generate_authentication_token!

	validates :auth_token, uniqueness: true
  validates :role, inclusion: { in: [1, 2, 3], message: "%{value} is not a valid role" }
  validates :first_name, :last_name, :email, :role, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :inventory_items
  has_many :logs
  has_and_belongs_to_many :projects

  # AVAILABLE ROLES
  ADMIN = 1
  PM = 2
  AE = 3
 	
 	def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  def get_role 
    case self.role
    when ADMIN
      "Admin"
    when PM
      "Project Manager"
    when AE
      "Account Executive"
    end
  end

  scope :admin_users, -> { where( role: ADMIN ) }
  scope :pm_users, -> { where( role: PM ) }
  scope :ae_users, -> { where( role: AE ) }
  scope :pm_ae_users, -> { where('role = ? OR role = ?', PM, AE ) }
end
