class InventoryItem < ActiveRecord::Base

  actable

  belongs_to :user
  belongs_to :project
  has_many :inventory_transactions

  validates :name, :status, :item_type, :user, :project, presence: true
  validates :barcode, presence: true, uniqueness: true

  # For item image
  has_attached_file :item_img, :styles => { :medium => "300x300>", :thumb => "150x150#" }, default_url: "/images/:style/missing.png", :path => ":rails_root/storage/#{Rails.env}#{ENV['RAILS_TEST_NUMBER']}/attachments/:id/:style/:basename.:extension", :url => ":rails_root/storage/#{Rails.env}#{ENV['RAILS_TEST_NUMBER']}/attachments/:id/:style/:basename.:extension"
  validates_attachment_content_type :item_img, content_type: /\Aimage\/.*\Z/

  scope :recent, -> {
    order(updated_at: :desc).limit(10)
  }

  def self.search( params = {} )
    inventory_items = InventoryItem.all
    inventory_items = inventory_items.recent if params[:recent].present?

    inventory_items
  end

  def get_details
    project = Project.find(self.project_id)
    pm = project.get_pm
    ae = project.get_ae
    client = project.get_client
    client_contact = project.get_client_contact
    puts item_img(:medium).gsub('/Users/micho/Documents/cuervo/sitios/', '')
    details = { 'inventory_item' => {
        'name'            => self.name,
        'actable_type'    => self.actable_type,
        'item_type'       => self.item_type,
        'barcode'         => self.barcode,
        'project'         => project.name,
        'pm'              => pm,
        'ae'              => ae,
        'description'     => self.description,
        'client'          => client,
        'client_contact'  => client_contact,
        'img'             => item_img(:medium).gsub('/Users/micho/Documents/cuervo/sitios/', '')
      }  
    }
    #details
  end

end
