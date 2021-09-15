require 'rails_helper'

RSpec.describe 'Customer_Subscriptions API', type: :request do
  describe 'controller update status action' do
    before(:each) do
      Customer.destroy_all
      Tea.destroy_all
      @customer = create(:customer)
      @tea = create(:tea)
      @subscription1 = create(:subscription, customer_id: @customer.id, status: 1)
      @subscription2 = create(:subscription, customer_id: @customer.id, status: 1)
    end

    # Happy Path
    it 'can update customer_subscription status in the database' do
      expect(@subscription1.status).to eq("active")
      expect(@subscription2.status).to eq("active")
      
      headers = {
        'Content-Type': "application/json"
      }

      body = {
        "status": 0
      }

      patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription2.id}", headers: headers, params: body.to_json
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(subscription[:data][:id].to_i).to eq(@subscription2.id)
      expect(subscription[:data][:attributes][:status]).to eq("cancelled")
    end

    # Sad Paths
    it 'can render error if invalid status given' do
      expect(@subscription1.status).to eq("active")
      expect(@subscription2.status).to eq("active")
      
      headers = {
        'Content-Type': "application/json"
      }

      body = {
        "status": 99
      }

      patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription2.id}", headers: headers, params: body.to_json
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(subscription[:errors]).to eq("'99' is not a valid status")
    end
  end
end
