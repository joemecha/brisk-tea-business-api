class Api::V1::CustomerSubscriptionsController < ApplicationController
  # before_action :set_customer, only: %i[index create update]
  
  def index
    # customer_subscriptions = Subscription.where(customer_id: params[:customer_id])
    # if subscriptions.empty?
    #   render json: {message: "No subscriptions for this customer."}
    # else
    #   render json: SubscriptionSerializer.new(subscriptions)
    # end
  end

  def create
    customer_subscription = CustomerSubscription.create(customer_subscription_params)
    if customer_subscription.save
      render json: CustomerSubscriptionSerializer.new(customer_subscription), status: :created
    else
      render json: { errors: 'Requires valid customer ID and subscription ID.' }, status: :bad_request
    end
  end

  def update
    # update status to 'cancelled'
    if params[:customer_id].present? && params[:subscription_id].present?
      customer_subscription = CustomerSubscription.find_by(customer_subscription_params)
      
      customer_subscription.cancel
      render json: CustomerSubscriptionSerializer.new(customer_subscription)
    else
      render json: { errors: 'Requires valid customer ID and subscription ID.' }, status: :bad_request
    end
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end