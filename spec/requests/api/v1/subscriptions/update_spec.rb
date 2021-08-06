require 'rails_helper'

RSpec.describe 'Customer_Subscriptions API', type: :request do
  describe 'controller update status action' do
    before(:each) do
      Customer.destroy_all

      @customer1 = create(:customer)
      @subscription1 = create(:subscription, status: "active")
      @customer_subscription1 = CustomerSubscription.create(customer_id: @customer1.id, subscription_id: @subscription1.id)      
    end

    # Happy Path
    it 'can update customer_subscription status in the database' do
      expect(@customer_subscription1.status).to eq("active")
      
      id = @customer_subscription1.id
      customer_subscription_params = { customer_id: @customer_subscription1.customer_id,
                                       subscription_id: @customer_subscription1.subscription_id
                                      }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/customer_subscriptions/#{id}", headers: headers, params: JSON.generate({customer_subscription: customer_subscription_params})

      cancelled_customer_sub = CustomerSubscription.find_by(customer_subscription_params)
      expect(cancelled_customer_sub.status).to eq("cancelled")
    end

    it 'can render response for update of subscription status' do
      id = @customer_subscription1.id
      customer_subscription_params = { customer_id: @customer_subscription1.customer_id,
                                       subscription_id: @customer_subscription1.subscription_id
                                      }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/customer_subscriptions/#{id}", headers: headers, params: JSON.generate({customer_subscription: customer_subscription_params})

      cancelled_customer_sub = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(cancelled_customer_sub[:data].count).to eq(3)
      expect(cancelled_customer_sub[:data][:attributes][:status]).to eq("cancelled")
    end

    # Sad Paths
    it 'can render error if customer_subscription does not exist' do
      customer_subscription_params = { customer_id: @customer_subscription1.customer_id,
                                       subscription_id: @customer_subscription1.subscription_id
                                      }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customer_subscriptions/999", headers: headers, params: JSON.generate({customer_subscription: customer_subscription_params})
      
      customer_sub = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"errors\":\"Couldn't find CustomerSubscription with 'id'=999\"}")
    end
    
    it 'can render error if missing params' do
      customer_subscription_params = { customer_id: @customer_subscription1.customer_id,
                                       subscription_id: ""
                                      }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customer_subscriptions/#{@customer_subscription1.id}", headers: headers, params: JSON.generate({customer_subscription: customer_subscription_params})
      
      customer_sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body).to eq("{\"errors\":\"Requires valid IDs for customer and subscription.\"}")
    end
  end
end