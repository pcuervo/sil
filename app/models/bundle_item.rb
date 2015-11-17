class BundleItem < ActiveRecord::Base
  acts_as :inventory_item
  has_many :bundle_item_parts

  validates :num_parts, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
end
