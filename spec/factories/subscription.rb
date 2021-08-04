FactoryBot.define do
  factory :subscription do
    title { Faker::Music::GratefulDead.song }
    price { ((5..75).to_a.sample * 100) }
    status { %w[active active active active active active active active active cancelled].sample }
    frequency { %w[monthly bimonthly trimonthly quarterly].sample }
    customer_id { 1 } # default if not defined in test
  end
end