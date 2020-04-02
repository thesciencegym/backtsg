Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'bing', to: 'users#bing'
  post 'payment_webhook', to: 'accept_payment#transaction_callback'
  get 'payment_webhook', to: 'accept_payment#transaction_callback'
  post 'paymob_notification_callback', to: 'accept_payment#notification_callback'
  get 'paymob_txn_response_callback', to: 'accept_payment#notification_callback'
end
