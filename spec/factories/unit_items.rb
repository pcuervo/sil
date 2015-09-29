FactoryGirl.define do
  factory :unit_item do
    name { FFaker::Product.product_name }
    description { FFaker::HipsterIpsum.paragraph }
    user
    serial_number { FFaker::IdentificationMX.curp }
    brand { FFaker::Product.brand }
    model { FFaker::Product.model }
  end

end
