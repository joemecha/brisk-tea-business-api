require 'rails_helper'

RSpec.describe 'API V1 Subscriptions Controller', type: :request do
  describe 'subscriptions controller update status action' do
    before(:each) do
      Customer.destroy_all
      Tea.destroy_all

      @customer1 = create(:customer)
      @subscription1a = create(:subscription, status: "active", customer_id: @customer1.id)
      @tea1 = create(:tea)
      @subscription_tea1 = create(:subscription_tea, subscription_id: @subscription1a.id, tea_id: @tea1.id)
    end

    # Happy Path
    it 'can render response for update of subscription status' do
      patch "/api/v1/subscriptions/#{@subscription1a.id}", params: {customer_id: "#{@customer1.id}"} # customer ID needed?
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(subscription[:data].count).to eq(1)
      expect(subscription[:data].first[:attributes][:status]).to eq("cancelled")
    end

    # Sad Paths
    it 'can render error if subscription does not exist' do
      patch "/api/v1/subscriptions/999", params: {customer_id: "#{@customer1.id}"} # customer ID needed?
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_unsuccessful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"No such subscription exists\"}")
    end
    
    it 'can render error if subscription id missing' do
      patch "/api/v1/subscriptions/", params: {id: ""}
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_unsuccessful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Subscription ID missing\"}")
    end

    # Return error if status already 'cancelled' ?
  end
end