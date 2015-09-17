FactoryGirl.define do
  factory :project do
    name { 'Project_' + random_number }
    litobel_id { FFaker::IdentificationMX.rfc }
    user
  end
end

def random_number
  rand(0...1000).to_s
end
