class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :subscription_teas, dependent: :destroy
  has_many :customers, through: :customer_subscriptions
  has_many :teas, through: :subscription_teas

  validates :title, :price, :status, :frequency, presence: true
  validates :price, numericality: true
end
