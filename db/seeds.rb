Customer.destroy_all
Tea.destroy_all

10.times do 
  customer = Customer.create(first_name: Faker::Name.first_name, 
                             last_name: Faker::Name.last_name, 
                             email: Faker::Internet.email, 
                             street: Faker::Address.street_address, 
                             city: Faker::Address.city, 
                             state: Faker::Address.state,
                             zip: Faker::Address.zip_code
                            )
  3.times do
    customer.subscriptions.create(title: "#{Faker::Music::GratefulDead.song} #{Faker::Tea.variety}", 
                                 price: ((5..75).to_a.sample * 100), 
                                 status: %w[active active active active active active active active active cancelled].sample,
                                 frequency: %w[monthly bimonthly trimonthly quarterly].sample
                                )
  end 
end
                            
10.times do
  tea = Tea.create(name: Faker::Tea.variety, 
            description: Faker::Lorem.sentence(word_count: 7), 
            temperature: [65, 70, 75, 80, 85, 100].sample, 
            brew_time: [60, 120, 180, 240, 300].sample
            )
end

subscription_tea_1a = SubscriptionTea.create(tea_id: 1, subscription_id: 1)
subscription_tea_1b = SubscriptionTea.create(tea_id: 2, subscription_id: 2)
subscription_tea_1c = SubscriptionTea.create(tea_id: 3, subscription_id: 3)
subscription_tea_2a = SubscriptionTea.create(tea_id: 4, subscription_id: 4)
subscription_tea_2b = SubscriptionTea.create(tea_id: 5, subscription_id: 5)
subscription_tea_2c = SubscriptionTea.create(tea_id: 6, subscription_id: 6)
subscription_tea_3a = SubscriptionTea.create(tea_id: 7, subscription_id: 7)
subscription_tea_3b = SubscriptionTea.create(tea_id: 8, subscription_id: 8)
subscription_tea_3c = SubscriptionTea.create(tea_id: 9, subscription_id: 9)
subscription_tea_4a = SubscriptionTea.create(tea_id: 10, subscription_id: 10)
subscription_tea_4b = SubscriptionTea.create(tea_id: 1, subscription_id: 11)
subscription_tea_4c = SubscriptionTea.create(tea_id: 2, subscription_id: 12)
subscription_tea_5a = SubscriptionTea.create(tea_id: 3, subscription_id: 13)
subscription_tea_5b = SubscriptionTea.create(tea_id: 4, subscription_id: 14)
subscription_tea_5c = SubscriptionTea.create(tea_id: 5, subscription_id: 15)
subscription_tea_6a = SubscriptionTea.create(tea_id: 6, subscription_id: 16)
subscription_tea_6b = SubscriptionTea.create(tea_id: 7, subscription_id: 17)
subscription_tea_6c = SubscriptionTea.create(tea_id: 8, subscription_id: 18)
subscription_tea_7a = SubscriptionTea.create(tea_id: 9, subscription_id: 19)
subscription_tea_7b = SubscriptionTea.create(tea_id: 10, subscription_id: 20)
subscription_tea_7c = SubscriptionTea.create(tea_id: 1, subscription_id: 21)
subscription_tea_8a = SubscriptionTea.create(tea_id: 2, subscription_id: 22)
subscription_tea_8b = SubscriptionTea.create(tea_id: 3, subscription_id: 23)
subscription_tea_8c = SubscriptionTea.create(tea_id: 4, subscription_id: 24)
subscription_tea_9a = SubscriptionTea.create(tea_id: 5, subscription_id: 25)
subscription_tea_9b = SubscriptionTea.create(tea_id: 6, subscription_id: 26)
subscription_tea_9c = SubscriptionTea.create(tea_id: 7, subscription_id: 27)
subscription_tea_10a = SubscriptionTea.create(tea_id: 8, subscription_id: 28)
subscription_tea_10b = SubscriptionTea.create(tea_id: 9, subscription_id: 29)
subscription_tea_10c = SubscriptionTea.create(tea_id: 10, subscription_id: 30)
