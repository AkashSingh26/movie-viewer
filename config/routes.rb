Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :ratings
    end
  end
  namespace :api do
    namespace :v1 do
      resources :genres
    end
  end
  namespace :api do
    namespace :v1 do
      resources :movies
    end
  end
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post '/auth/sign_up', to: 'auth#sign_up'
        post '/auth/sign_in', to: 'auth#sign_in'
        delete '/auth/sign_out', to: 'auth#sign_out'
        patch '/auth/update', to: 'auth#update'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
