class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :teas, through: :subscriptions

  validates :first_name, :last_name, :email, :street, :city, :state, :zip, presence: true
end
