class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, :price, :status, :frequency, presence: true
  validates :price, numericality: true

  enum status: [:cancelled, :active]
  enum frequency: [:monthly, :bimonthly, :trimonthly, :biannually]
end
