class BundleItem < ActiveRecord::Base
  acts_as :inventory_item
  has_many :bundle_item_parts

  validates :num_parts, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true

  def update_num_parts
    self.num_parts = self.bundle_item_parts.count
    self.save
  end

  def add_parts( parts = [] )

    parts.each do |p|
      new_part = BundleItemPart.create( parts_params( p )  )
      self.bundle_item_parts << new_part
    end
    update_num_parts
  end

  private 
    def parts_params( params )
      params.permit( :name, :serial_number, :brand, :model )
    end
end
