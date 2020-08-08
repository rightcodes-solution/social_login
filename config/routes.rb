Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth'}
  resources :providers
  root to: 'home#index'
end
