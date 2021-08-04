require 'rails_helper'

RSpec.describe 'Subscriptions API', type: :request do
  describe 'subscriptions controller index action' do
    before(:each) do
      Customer.destroy_all
      Tea.destroy_all

      @customer1 = create(:customer)
      @customer2 = create(:customer)

      @subscription1a = create(:subscription, status: "active", customer_id: @customer1.id)
      @subscription1b = create(:subscription, status: "active", customer_id: @customer1.id)
      @subscription1c = create(:subscription, status: "cancelled", customer_id: @customer1.id)

      @tea1 = create(:tea)
      @tea2 = create(:tea)
      @tea3 = create(:tea)

      @subscription_tea1 = create(:subscription_tea, subscription_id: @subscription1a.id, tea_id: @tea1.id)
      @subscription_tea2 = create(:subscription_tea, subscription_id: @subscription1b.id, tea_id: @tea2.id)
      @subscription_tea3 = create(:subscription_tea, subscription_id: @subscription1c.id, tea_id: @tea3.id)
    end

    # Happy Path
    it 'can render active and cancelled subscriptions for an individual user' do
      get '/api/v1/subscriptions', params: {customer_id: "#{@customer1.id}"}
      subscriptions = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(subscriptions[:data].count).to eq(3)
      expect(subscriptions[:data].first[:attributes][:title]).to eq(@subscription1a.title)
    end
    
    # Sad Paths
    it 'renders error if no customer id' do
      get '/api/v1/subscriptions', params: {customer_id: ""}
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_unsuccessful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Customer ID missing\"}")
    end
    
    it 'renders error if customer does not exist' do
      get '/api/v1/subscriptions', params: {customer_id: "999"}
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_unsuccessful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Invalid customer ID\"}")
    end

    it 'renders error if no subscriptions exist' do
      get '/api/v1/subscriptions', params: {customer_id: @customer2.id}
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_unsuccessful
      expect(response.status).to eq(200)
      expect(response.body).to eq("{\"errors\":\"No subscriptions for customer\"}")
    end
  end
end