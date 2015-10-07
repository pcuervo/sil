class InventoryItem < ActiveRecord::Base

  actable

  belongs_to :user
  belongs_to :project
  has_many :inventory_transaction

  validates :name, :status, :user, :project, presence: true

  # For item image
  has_attached_file :item_img, :styles => { :medium => "300x300>", :thumb => "150x150#" }, default_url: "/images/:style/missing.png", :path => ":rails_root/storage/#{Rails.env}#{ENV['RAILS_TEST_NUMBER']}/attachments/:id/:style/:basename.:extension", :url => ":rails_root/storage/#{Rails.env}#{ENV['RAILS_TEST_NUMBER']}/attachments/:id/:style/:basename.:extension"
  validates_attachment_content_type :item_img, content_type: /\Aimage\/.*\Z/

end
