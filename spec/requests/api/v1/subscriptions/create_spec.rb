require 'rails_helper'

RSpec.describe 'Customer_Subscriptions API', type: :request do
  describe 'customer_subscriptions controller create action' do
    before(:each) do
      Customer.destroy_all

      @customer1 = create(:customer)
      @subscription1 = create(:subscription, status: "active")

      @customer2 = create(:customer)
      @subscription2 = create(:subscription, status: "active")
    end
    
    # Happy Path
    it 'can save a new customer_subscription to the database' do
      customer_subscription_params = ({
        customer_id: @customer1.id,
        subscription_id: @subscription1.id
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/customer_subscriptions', headers: headers, 
                                             params: JSON.generate(customer_subscription: customer_subscription_params)

      new_customer_subscription = CustomerSubscription.last

      expect(new_customer_subscription.customer_id).to eq(@customer1.id)
      expect(new_customer_subscription.subscription_id).to eq(@subscription1.id)
      expect(new_customer_subscription.customer_id).to_not eq(@customer2.id)
      expect(new_customer_subscription.customer_id).to_not eq(@subscription2.id)
    end
    
    it 'can render response for creation of new subscription' do
      customer_subscription_params = ({
        customer_id: @customer1.id,
        subscription_id: @subscription1.id
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/customer_subscriptions', headers: headers, 
                                             params: JSON.generate(customer_subscription: customer_subscription_params)

      customer_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(customer_subscription.keys).to match_array([:data])
      expect(customer_subscription).to be_a(Hash)
      expect(customer_subscription[:data].count).to eq(3)
      expect(customer_subscription[:data][:type]).to eq("customer_subscription")
      expect(customer_subscription[:data][:attributes].count).to eq(3)
      expect(customer_subscription[:data][:attributes]).to have_key(:customer_id)
      expect(customer_subscription[:data][:attributes]).to have_key(:subscription_id)
    end

    # Sad Paths
    it 'can render an error message if missing a required parameter in the request body' do

      customer_subscription_params = ({
        customer_id: @customer_id,
        subscription_id: ""
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/customer_subscriptions', headers: headers, 
                                             params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error[:error]).to eq("Requires valid customer ID and subscription ID.")
    end

    it 'can render an error message if an id does not match an existing customer' do
      customer_subscription_params = ({
        customer_id: 999,
        subscription_id: @subscription1.id
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/customer_subscriptions', headers: headers, 
                                             params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error[:error]).to eq("Customer with ID='999' does not exist.")
    end
    
    it 'can render an error message if an id does not match an existing subscription' do
      customer_subscription_params = ({
        customer_id: @customer1.id,
        subscription_id: 999
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/customer_subscriptions', headers: headers, 
                                             params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error[:error]).to eq("Subscription with ID='999' does not exist.")
    end
  end
end