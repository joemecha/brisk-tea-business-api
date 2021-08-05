class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :price, :status, :frequency
end
