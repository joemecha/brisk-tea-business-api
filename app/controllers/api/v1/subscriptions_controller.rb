class Api::V1::SubscriptionsController < ApplicationController
  before_action :set_customer, only: %i[index create update]
  
  def index
    subscriptions = Subscription.where(customer_id: params[:customer_id])
    # serializer here
  end

  def create
    subscription = @customer.subscriptions.new(subscription_params)
    if subscription.save
      # serializer
    else
      # render error
    end
  end

  def update
    # update status to cancelled
    # find subscription
    subscription = Subscription.find(params[:id])
    if subscription.nil?
      # render error

      # other errors? check sad path tests
    else
      subscription.status = "cancelled"
      subscription.save
      # render response with serializer
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id)
  end

  def set_customer
    @customer = Customer.find_by(id: params[:id])
  end
end