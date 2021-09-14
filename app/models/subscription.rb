class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, :price, :status, :frequency, presence: true
  validates :price, :frequency, :status, numericality: true

  enum status: { cancelled: 0, active: 1 }
  enum frequency: { monthly: 0, bimonthly: 1, trimonthly: 2, biannually: 3 }
end
