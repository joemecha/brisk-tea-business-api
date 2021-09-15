require 'rails_helper'

RSpec.describe 'Customer Subscriptions API', type: :request do
  describe 'controller index action' do
    before(:each) do
      Subscription.destroy_all
      Customer.destroy_all
      Tea.destroy_all

      @customer = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)

      @tea1 = create(:tea)
      @tea2 = create(:tea)
      @tea3 = create(:tea)

      @subscription1 = create(:subscription, status: 1, customer_id: @customer.id, tea_id: @tea1.id)
      @subscription2 = create(:subscription, status: 1, customer_id: @customer.id, tea_id: @tea2.id)
      @subscription3 = create(:subscription, status: 0, customer_id: @customer.id, tea_id: @tea3.id)
      @subscription4 = create(:subscription, status: 1, customer_id: @customer2.id, tea_id: @tea1.id)
    end

    # Happy Path
    it 'can render active and cancelled subscriptions for an individual customer' do
      get "/api/v1/customers/#{@customer.id}/subscriptions"
      subscriptions = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      expect(subscriptions[:data]).to be_an(Array)
      expect(subscriptions[:data].count).to eq(3)
      expect(subscriptions[:data].first[:attributes]).to have_key(:tea_id)
      expect(subscriptions[:data].first[:attributes]).to have_key(:title)
      expect(subscriptions[:data].first[:attributes]).to have_key(:price)
      expect(subscriptions[:data].first[:attributes]).to have_key(:status)
      expect(subscriptions[:data].first[:attributes][:title]).to eq(@subscription1.title)
      expect(subscriptions[:data].first[:attributes][:price]).to eq(@subscription1.price)
      expect(subscriptions[:data].first[:attributes][:frequency]).to eq(@subscription1.frequency)
      expect(subscriptions[:data].last[:attributes][:title]).to eq(@subscription3.title)
      expect(subscriptions[:data].last[:attributes][:price]).to eq(@subscription3.price)
      expect(subscriptions[:data].last[:attributes][:frequency]).to eq(@subscription3.frequency)
      expect(subscriptions[:data][2][:attributes][:status]).to eq("cancelled")
    end
    
    # Sad Paths    
    it 'renders error if customer does not exist' do
      id = 999
      get "/api/v1/customers/999/subscriptions"
      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"errors\":\"Cannot find customer with ID #{id}\"}")
    end

    it 'renders error if no subscriptions exist' do
      get "/api/v1/customers/#{@customer3.id}/subscriptions"
      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.body).to eq("{\"message\":\"There are no subscriptions for this customer.\"}")
    end
  end
end