require 'rails_helper'

RSpec.describe 'Customer Subscriptions API', type: :request do
  describe 'controller show action' do
    before(:each) do
      Customer.destroy_all
      Tea.destroy_all

      @customer = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)

      @subscription1 = create(:subscription, status: "active")
      @subscription2 = create(:subscription, status: "active")
      @subscription3 = create(:subscription, status: "cancelled")
      @subscription4 = create(:subscription, status: "active")

      customer_subscription1 = create(:customer_subscription, customer_id: @customer.id, subscription_id: @subscription1.id)
      customer_subscription2 = create(:customer_subscription, customer_id: @customer.id, subscription_id: @subscription2.id)
      customer_subscription3 = create(:customer_subscription, customer_id: @customer.id, subscription_id: @subscription3.id)
      customer_subscription4 = create(:customer_subscription, customer_id: @customer2.id, subscription_id: @subscription4.id)

      @tea1 = create(:tea)
      @tea2 = create(:tea)
      @tea3 = create(:tea)

      @subscription_tea1 = create(:subscription_tea, subscription_id: @subscription1.id, tea_id: @tea1.id)
      @subscription_tea2 = create(:subscription_tea, subscription_id: @subscription2.id, tea_id: @tea2.id)
      @subscription_tea3 = create(:subscription_tea, subscription_id: @subscription3.id, tea_id: @tea3.id)
    end

    # Happy Path
    it 'can render active and cancelled subscriptions for an individual user' do
      get "/api/v1/customer_subscriptions/#{@customer.id}", params: {customer_id: "#{@customer.id}"}
      
      subscriptions = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      expect(subscriptions[:data].count).to eq(3)
      expect(subscriptions[:data].first[:attributes][:title]).to eq(@subscription1.title)
      expect(subscriptions[:data].first[:attributes][:price]).to eq(@subscription1.price)
      expect(subscriptions[:data].first[:attributes][:frequency]).to eq(@subscription1.frequency)
      expect(subscriptions[:data].last[:attributes][:title]).to eq(@subscription3.title)
      expect(subscriptions[:data].last[:attributes][:price]).to eq(@subscription3.price)
      expect(subscriptions[:data].last[:attributes][:frequency]).to eq(@subscription3.frequency)
    end
    
    # Sad Paths    
    it 'renders error if customer does not exist' do
      id = 999
      get "/api/v1/customer_subscriptions/#{id}", params: {id: "999"}
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"errors\":\"Missing or invalid ID\"}")
    end

    it 'renders error if no subscriptions exist' do
      get "/api/v1/customer_subscriptions/#{@customer3.id}", params: {id: @customer3.id}
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.body).to eq("{\"message\":\"There are no subscriptions for this customer.\"}")
    end
  end
end