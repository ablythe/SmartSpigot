Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks" }
  
  root 'welcome#index'

  resources :spigots do
    resources :waterings, only: [:new, :create, :show, :update, :destroy]
  end

end