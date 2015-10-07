FactoryGirl.define do
  factory :inventory_transaction do
    entry_date { FFaker::Time.date }
    inventory_item
    concept "Entrada unitaria"
    estimated_issue_date { FFaker::Time.date }
    additional_comments { FFaker::HipsterIpsum.paragraph }
    delivery_company { FFaker::Product.brand }
    delivery_company_contact { FFaker::PhoneNumber.phone_number }
  end

end
