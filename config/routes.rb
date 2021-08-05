Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customer_subscriptions, only: %i[index create update]
    end
  end
end
