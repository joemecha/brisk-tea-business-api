class Api::V1::CustomerSubscriptionsController < ApplicationController
  def show
    customer = Customer.find(params[:id])
    subscriptions = customer.subscriptions
    if subscriptions.empty?
      render json: { message: 'There are no subscriptions for this customer.' }
    else
      render json: SubscriptionSerializer.new(subscriptions)
    end
  end

  def create
    new_customer_subscription = CustomerSubscription.create(customer_subscription_params)

    if new_customer_subscription.save
      render json: CustomerSubscriptionSerializer.new(new_customer_subscription), status: :created
    else
      render json: { errors: 'Requires valid customer ID and subscription ID.' }, status: :bad_request
    end
  end

  def update
    CustomerSubscription.find(customer_subscription_params)
    if params[:customer_subscription][:customer_id].present? && params[:customer_subscription][:subscription_id].present?
      customer_sub = CustomerSubscription.find_by(customer_subscription_params)

      cancelled_sub = CustomerSubscription.update(customer_sub.id, status: 'cancelled')
      render json: CustomerSubscriptionSerializer.new(cancelled_sub)
    else
      render json: { errors: 'Requires valid IDs for customer and subscription.' }, status: :bad_request
    end
  end

  private

  def customer_subscription_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id)
  end
end