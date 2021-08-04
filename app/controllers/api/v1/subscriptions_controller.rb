class Api::V1::SubscriptionsController < ApplicationController
  # before_action :set_customer, only: %i[index create update]
  
  def index
    subscriptions = Subscription.where(customer_id: params[:customer_id])
    if subscriptions.empty?
      render json: {message: "No subscriptions for this customer."}
    else
      render json: SubscriptionSerializer.new(subscriptions)
    end
  end

  def create
    customer = Customer.find(params[:customer_id]) # Is this necessary? Can just do Subscription.new on next line
    subscription = customer.subscriptions.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { errors: 'Subscription not saved. Missing required information.' }, status: :bad_request
    end
  end

  def update
    # update status to 'cancelled'
    subscription = Subscription.find_by(params[:subscription_id])
    if subscription.nil?
      render json: { errors: 'No such subscription exists.' }, status: :bad_request
    else
      subscription = Subscription.update(status: "cancelled")
      subscription.save
      render json: SubscriptionSerializer.new(subscription)
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id)
  end

  # def set_customer
  #   @customer = Customer.find_by(id: params[:customer_id])
  # end
end