FactoryGirl.define do
  factory :client do
    name { FFaker::CompanyIT.name }
  end
end
