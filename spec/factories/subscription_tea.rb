FactoryBot.define do
  factory :subscription_tea do
    subscription_id { 1 } # default if not defined in test
    tea_id { 1 } # default if not defined in test
  end
end