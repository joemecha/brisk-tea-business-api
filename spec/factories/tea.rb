FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety } 
    description { Faker::Lorem.sentence(word_count: 5) }
    temperature { [65, 70, 75, 80, 85, 100].sample } 
    brew_time { [60, 120, 180, 240, 300].sample }
  end
end