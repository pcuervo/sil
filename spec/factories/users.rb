FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "holama123"
    password_confirmation "holama123"
  end
end
