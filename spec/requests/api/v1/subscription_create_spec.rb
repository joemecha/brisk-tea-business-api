require 'rails_helper'

RSpec.describe 'API V1 Subscriptions Controller', type: :request do
  describe 'subscriptions controller create action' do
    before(:each) do
      Customer.destroy_all
      Tea.destroy_all

      @customer1 = create(:customer)
      @subscription1a = create(:subscription, status: "active", customer_id: @customer1.id)
      @tea1 = create(:tea)
      @subscription_tea1 = create(:subscription_tea, subscription_id: @subscription1a.id, tea_id: @tea1.id)
    end
    
    # Happy Path
    it 'can render response for creation of new subscription' do
      post '/api/v1/subscriptions', params: {title: "Tea of the Month",
                                             price: 2000,
                                             status: "active",
                                             frequency: "monthly",
                                             customer_id: @customer1.id
                                            }
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(subscription[:data].count).to eq(1)
      expect(subscription[:data].first[:attributes][:title]).to eq("Tea of the Month")
    end

    # Sad Paths
    it 'can render error if params missing' do
      post "/api/v1/subscriptions/", params: {title: "Tea of the Day",
                                             price: 2000,
                                             status: "active",
                                             frequency: "monthly",
                                             customer_id: @customer1.id
                                            }
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_unsuccessful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Subscription ID missing\"}")
    end
  end
end