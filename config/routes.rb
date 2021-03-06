Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks" }
  
  root 'welcome#index'
  get "/about", to: "welcome#about"

  resources :spigots do
    resources :waterings, only: [:new, :create, :show, :update, :destroy]
    get "/usages", to: "usages#minutes"
    get "/gallons", to: "usages#gallons"
    get '/status', to: "spigots#status"
    patch "/on", to: "spigots#on"
    patch "/off", to: "spigots#off"
  end

end
