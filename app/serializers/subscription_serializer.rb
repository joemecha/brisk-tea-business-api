class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :price, :status, :frequency, :customer_id
  has_many :teas, if: proc { |record| record.teas.any? }
end