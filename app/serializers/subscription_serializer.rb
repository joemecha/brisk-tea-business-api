class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :price, :status, :frequency
  has_many :teas, if: proc { |record| record.teas.any? }
end