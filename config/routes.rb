Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'order', to: 'users#order'
  post 'payment_webhook', to: 'accept_payment#transaction_callback'
  post 'cash_transaction_callback', to: 'accept_payment#cash_transaction_callback'
  post 'delivery_callback', to: 'accept_payment#delivery_callback'
  get 'order/:id', to: 'orders#show'
end
