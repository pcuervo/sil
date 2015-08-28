FactoryGirl.define do
  factory :project do
    name { FFaker::Skill.specialties }
    litobel_id { FFaker::IdentificationMX.rfc }
  end

end
