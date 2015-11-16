FactoryGirl.define do
  factory :unit_item do
    name { FFaker::Product.product_name }
    description { FFaker::HipsterIpsum.paragraph }
    user
    project
    serial_number { FFaker::IdentificationMX.curp }
    barcode { FFaker::Vehicle.vin }
    brand { FFaker::Product.brand }
    model { FFaker::Product.model }
    item_type 'Desktop'
  end

end
