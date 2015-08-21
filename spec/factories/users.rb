FactoryGirl.define do
  factory :user do
  	#first_name "Juan"
  	#last_name "Pérez"
    email { FFaker::Internet.email }
    password "holama123"
    password_confirmation "holama123"
    #role "admin"
  end
end
