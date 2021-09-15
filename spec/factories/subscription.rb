FactoryBot.define do
  factory :subscription do
    title { "#{Faker::Music::GratefulDead.song} #{Faker::Tea.variety} Tea Box"}
    price { ((5..75).to_a.sample * 100) }
    status { [1, 1, 1, 1, 1, 1, 1, 1, 1, 0].sample }
    frequency { [0, 1, 2, 3].sample }
    tea
    customer
  end
end