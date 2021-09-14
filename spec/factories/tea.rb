FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety } 
    description { Faker::Lorem.sentence(word_count: 5) }
    temperature { Faker::Number.between(from: 65, to: 100) } 
    brew_time { [60, 120, 180, 240, 300].sample }
  end
end