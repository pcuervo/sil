FactoryGirl.define do
  factory :inventory_item do
    name { FFaker::Product.product_name }
    description { FFaker::HipsterIpsum.paragraph } 
    user
    project
  end
end
