class Api::V1::Customers::SubscriptionsController < ApplicationController
  before_action :set_customer
  before_action :set_tea, only: %i[create]

  def index
    if @customer.subscriptions.count.zero?
      render json: { message: 'There are no subscriptions for this customer.' }
    else
      render json: SubscriptionSerializer.new(@customer.subscriptions)
    end
  end

  def create
    subscription = @customer.subscriptions.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def update
    subscription = @customer.subscriptions.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end

  def set_customer
    @customer = Customer.find_by(id: params[:customer_id])
    if @customer.nil?
      render json: { errors: "Cannot find customer with ID #{params[:customer_id]}" }, status: :not_found
    end
  end

  def set_tea
    @tea = Tea.find_by(id: params[:tea_id])
    render json: { errors: "Cannot find tea with ID #{params[:tea_id]}" }, status: :not_found if @tea.nil?
  end
end
