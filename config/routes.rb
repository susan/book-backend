Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
  	namespace :v1 do
  		resources :books
  		resources :carts
      #resources :users
  		post "/users", to: "users#create"
  		post "/login", to: "auth#create"
      get '/curr_user', to: "auth#show"

  	end
  end

    root to: "home#index"

end
