Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    defaults format: :json do
      resources :boats, only: [:index, :create]
      resources :timeslots, only: [:index, :create]
      resources :assignments, only: [:create]
    end
  end

end
