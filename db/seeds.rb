Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

5.times do
  Tea.create(name: Faker::Tea.variety, 
            description: Faker::Lorem.sentence(word_count: 5), 
            temperature: [65, 70, 75, 80, 85, 100].sample, 
            brew_time: [60, 120, 180, 240, 300].sample
            )
end

5.times do 
  Customer.create(first_name: Faker::Name.first_name, 
                  last_name: Faker::Name.last_name, 
                  email: Faker::Internet.email, 
                  street: Faker::Address.street_address, 
                  city: Faker::Address.city, 
                  state: Faker::Address.state,
                  zip: Faker::Address.zip_code
                  )
end

5.times do
    Customer.all.sample.subscriptions.create(
        title: "#{Faker::Music::GratefulDead.song} #{Faker::Tea.variety} Tea Box", 
        price: ((5..75).to_a.sample * 100), 
        status: [1, 1, 1, 1, 1, 1, 1, 1, 1, 0].sample,
        frequency: [0, 1, 2, 3].sample,
        tea_id: Tea.all.sample.id
        )
end
