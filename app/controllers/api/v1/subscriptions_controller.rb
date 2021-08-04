class Api::V1::SubscriptionsController < ApplicationController
  # before_action :set_customer, only: %i[index create update]
  
  def index
    subscriptions = Subscription.where(customer_id: params[:customer_id])
    render json: SubscriptionSerializer.new(subscriptions)
    # add error
  end

  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: { errors: 'Subscription not saved. Missing required information.' }, status: :bad_request
    end
  end

  def update
    # update status to cancelled
    # find subscription
    subscription = Subscription.find_by(params[:subscription_id])
    if subscription.nil?
      # render error

      # other errors? check sad path tests
    else
      subscription.status = "cancelled"
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