require 'rails_helper'

RSpec.describe 'Customer_Subscriptions API', type: :request do
  describe 'customer_subscriptions controller create action' do
    before(:each) do
      Customer.destroy_all

      @customer1 = create(:customer)
      @subscription1 = create(:subscription, status: "active")
    end
    
    # Happy Path
    it 'can render response for creation of new subscription' do
      post '/api/v1/customer_subscriptions', params: {customer_id: @customer1.id,
                                             subscription_id: @subscription1.id
                                            }
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(subscription[:data].count).to eq(3)
      expect(subscription[:data][:type]).to eq("customer_subscription")
      expect(subscription[:data][:attributes].count).to eq(3)
      expect(subscription[:data][:attributes]).to have_key(:customer_id)
      expect(subscription[:data][:attributes]).to have_key(:subscription_id)
      expect(subscription[:data][:attributes]).to have_key(:status)
    end

    # Sad Paths
    it 'can render error if params missing' do
      post "/api/v1/customer_subscriptions/", params: {customer_id: @customer1.id,
                                                       subscription_id: ""
                                                      }
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Requires valid customer ID and subscription ID.\"}")
    end
  end
end