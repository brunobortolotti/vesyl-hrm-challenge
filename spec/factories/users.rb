FactoryBot.define do
  factory :user do
    username { "MyString" }
    gender { "MyString" }
    age { 1 }
    hr_zone1_bpm_min { 1 }
    hr_zone1_bpm_max { 1 }
  end
end
