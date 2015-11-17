FactoryGirl.define do
  factory :bundle_item do
    name { FFaker::Product.product_name }
    description { FFaker::HipsterIpsum.paragraph }
    user
    project
    barcode { FFaker::Vehicle.vin }
    item_type 'POP'
    is_complete true
    num_parts 3
  end

end
