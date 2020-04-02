Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'bing', to: 'users#bing'
  get 'bing', to: 'users#bing'
  post 'payment_webhook', to: 'accept_payment#transaction_callback'
  get 'payment_webhook', to: 'accept_payment#transaction_callback'
end
