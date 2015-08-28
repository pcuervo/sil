FactoryGirl.define do
  factory :project do
    name { FFaker::Skill.specialties }
    litobel_id "HP/123"
  end

end
