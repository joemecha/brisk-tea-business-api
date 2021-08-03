class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas, dependent: :destroy

  validates :title, :price, :status, :frequency, :customer_id, presence: true
  validates :price, :customer_id, numericality: true
end
