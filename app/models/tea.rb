class Tea < ApplicationRecord
  has_many :subscriptions
  validates :name, :description, :temperature, :brew_time, presence: true
  validates :temperature, :brew_time, numericality: true
end
