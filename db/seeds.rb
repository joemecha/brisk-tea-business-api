Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

5.times do 
  customer = Customer.create(first_name: Faker::Name.first_name, 
                             last_name: Faker::Name.last_name, 
                             email: Faker::Internet.email, 
                             street: Faker::Address.street_address, 
                             city: Faker::Address.city, 
                             state: Faker::Address.state,
                             zip: Faker::Address.zip_code
                            )
end

10.times do
    subscription = Subscription.create(title: "#{Faker::Music::GratefulDead.song} #{Faker::Tea.variety} Tea Box", 
                                 price: ((5..75).to_a.sample * 100), 
                                 status: %w[active active active active active active active active active cancelled].sample,
                                 frequency: [12, 6, 4].sample
                                )
end 

customer_subscription_1 = CustomerSubscription.create(customer_id: 1, subscription_id: 1)
customer_subscription_2 = CustomerSubscription.create(customer_id: 2, subscription_id: 2)
customer_subscription_3 = CustomerSubscription.create(customer_id: 3, subscription_id: 3)
customer_subscription_4 = CustomerSubscription.create(customer_id: 4, subscription_id: 4)
customer_subscription_5 = CustomerSubscription.create(customer_id: 5, subscription_id: 5, status: "cancelled")

customer_subscription_6 = CustomerSubscription.create(customer_id: 1, subscription_id: 6, status: "cancelled")
customer_subscription_7 = CustomerSubscription.create(customer_id: 2, subscription_id: 7, status: "cancelled")
customer_subscription_8 = CustomerSubscription.create(customer_id: 3, subscription_id: 8)
customer_subscription_9 = CustomerSubscription.create(customer_id: 4, subscription_id: 9)
customer_subscription_10 = CustomerSubscription.create(customer_id: 5, subscription_id: 10)


10.times do
  tea = Tea.create(name: Faker::Tea.variety, 
            description: Faker::Lorem.sentence(word_count: 5), 
            temperature: [65, 70, 75, 80, 85, 100].sample, 
            brew_time: [60, 120, 180, 240, 300].sample
            )
end

subscription_tea_1 = SubscriptionTea.create(tea_id: 1, subscription_id: 1)
subscription_tea_2 = SubscriptionTea.create(tea_id: 2, subscription_id: 2)
subscription_tea_3 = SubscriptionTea.create(tea_id: 3, subscription_id: 3)
subscription_tea_4 = SubscriptionTea.create(tea_id: 4, subscription_id: 4)
subscription_tea_5 = SubscriptionTea.create(tea_id: 5, subscription_id: 5)
subscription_tea_6 = SubscriptionTea.create(tea_id: 6, subscription_id: 6)
subscription_tea_7 = SubscriptionTea.create(tea_id: 7, subscription_id: 7)
subscription_tea_8 = SubscriptionTea.create(tea_id: 8, subscription_id: 8)
subscription_tea_9 = SubscriptionTea.create(tea_id: 9, subscription_id: 9)
subscription_tea_10 = SubscriptionTea.create(tea_id: 10, subscription_id: 10)