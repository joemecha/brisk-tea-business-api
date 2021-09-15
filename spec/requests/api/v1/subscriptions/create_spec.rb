require 'rails_helper'

RSpec.describe 'Customer_Subscriptions API', type: :request do
  describe 'customer new subscription controller create action' do    
    # Happy Path
    it "can save a customer's new subscription to the database" do
      customer = create(:customer)
      tea = create(:tea)

      headers = {"Content-Type": "application/json"}

      body = {
        "tea_id": tea.id,
        "title": "#{customer.first_name}'s Subscription for #{tea.name}",
        "price": 1500,
        "frequency": 2
      }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, 
                                             params: body.to_json
      new_sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(new_sub[:data]).to be_a(Hash)
      expect(new_sub[:data][:attributes]).to have_key(:customer_id)
      expect(new_sub[:data][:attributes]).to have_key(:tea_id)
      expect(new_sub[:data][:attributes]).to have_key(:title)
      expect(new_sub[:data][:attributes]).to have_key(:price)
      expect(new_sub[:data][:attributes]).to have_key(:frequency)
      expect(new_sub[:data][:attributes]).to have_key(:status)
      
      expect(new_sub[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(new_sub[:data][:attributes][:tea_id]).to eq(tea.id)
      expect(new_sub[:data][:attributes][:price]).to eq(1500)
      expect(new_sub[:data][:attributes][:frequency]).to eq("trimonthly")
      expect(new_sub[:data][:attributes][:status]).to eq("active")
    end

    # Sad Paths
    it 'can render an error message if missing a required parameter in the request body' do
      customer = create(:customer)
      tea = create(:tea)

      headers = {"Content-Type": "application/json"}

      body = {
        "tea_id": tea.id,
        "title": "#{customer.first_name}'s Subscription for #{tea.name}",
        "price": 1500,
      }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, 
                                             params: body.to_json
      new_sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error[:errors]).to eq("Frequency can't be blank")
    end

    it 'can render an error message if an id does not match an existing tea' do
      customer = create(:customer)
      tea = create(:tea)

      headers = {"Content-Type": "application/json"}

      body = {
        "tea_id": 9999,
        "title": "#{customer.first_name}'s Subscription for #{tea.name}",
        "price": 1500,
        "frequency": 1
      }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, 
                                             params: body.to_json
      new_sub = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error[:errors]).to eq("Cannot find tea with ID 9999")
    end
  end
end