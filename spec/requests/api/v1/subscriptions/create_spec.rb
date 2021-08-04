require 'rails_helper'

RSpec.describe 'Subscriptions API', type: :request do
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
      expect(response.status).to eq(200) # How can get 201 ?
      expect(subscription[:data].count).to eq(4)
      expect(subscription[:data][:attributes][:title]).to eq('Tea of the Month')
    end

    # Sad Paths
    it 'can render error if params missing' do
      post "/api/v1/subscriptions/", params: {title: '',
                                             price: nil,
                                             status: 'active',
                                             frequency: nil,
                                             customer_id: @customer1.id
                                            }
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Subscription not saved. Missing required information.\"}")
    end
  end
end