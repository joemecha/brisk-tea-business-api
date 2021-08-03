class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :subscription_teas, through: :subscriptions
  has_many :teas, through: :subscription_teas
  validates :first_name, :last_name, :email, :street, :city, :state, :zip, presence: true
end