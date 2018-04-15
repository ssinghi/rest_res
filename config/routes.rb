Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, format: :json do
    resources :restaurants, only: [] do
      member do
        get :reservations
      end
    end

    resources :reservations, only: [:create, :update]
  end
end
