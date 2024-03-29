Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users, only: [:index, :edit, :show, :update]
  root 'pages#index'
  get 'pages/index'
  get 'pages/activity'
end
