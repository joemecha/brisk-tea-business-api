FactoryBot.define do
  factory :customer_subscription do
    customer_id { 1 } # default if not defined in test
    subscription_id { 1 } # default if not defined in test
    status { "active" } # default if not defined in test
  end
end