FactoryBot.define do
  factory :subscription do
    title { Faker::Music::GratefulDead.song }
    price { ((5..75).to_a.sample * 100) }
    status { %w[active active active active active active active active active cancelled].sample }
    frequency { [12, 6, 4].sample }
  end
end