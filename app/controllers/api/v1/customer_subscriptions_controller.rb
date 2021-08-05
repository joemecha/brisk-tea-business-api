class Api::V1::CustomerSubscriptionsController < ApplicationController
  def show
    customer = Customer.find(params[:id])
    subscriptions = customer.subscriptions
    if subscriptions.empty?
      render json: {message: "There are no subscriptions for this customer."}
    else
      render json: SubscriptionSerializer.new(subscriptions)
    end
  end

  def create
    customer_sub = CustomerSubscription.create(customer_subscription_params)
    if customer_sub.save
      render json: CustomerSubscriptionSerializer.new(customer_sub), status: :created
    else
      render json: { errors: 'Requires valid customer ID and subscription ID.' }, status: :bad_request
    end
  end

  def update
    customer_sub = CustomerSubscription.find(params[:id])
    if params[:customer_subscription][:customer_id].present? && params[:customer_subscription][:subscription_id].present?
      customer_sub = CustomerSubscription.find_by(customer_subscription_params)
      
      cancelled_sub = CustomerSubscription.update(customer_sub.id, status: 'cancelled')
      render json: CustomerSubscriptionSerializer.new(cancelled_sub)
    elsif 
      render json: { errors: 'Requires valid IDs for customer and subscription.' }, status: :bad_request
    end
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end