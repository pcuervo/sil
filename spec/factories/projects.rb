FactoryGirl.define do
  factory :project do
    name { FFaker::Skill.specialty }
    litobel_id { FFaker::IdentificationMX.rfc }
    user
  end

end
