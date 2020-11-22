Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :restaurants do
        resources :reservations
        resources :comments
          collection do
            get :search
          end
      end
    end
  end

  root to: "home#index"

  post "signin",controller: :signin, action: :create
  post "signup",controller: :signup, action: :create
  delete "signin", controller: :signin, action: :destroy

end
