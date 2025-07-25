Rails.application.routes.draw do
  # Home page
  root "home#index"

  # Devise for users (public users)
  devise_for :users

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Publicly accessible: view events and show event details
  resources :events do
    resources :registrations, only: [:new, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    root to: "dashboard#index"  # Admin landing page

    resources :events do
      resources :registrations, only: [:index, :edit, :update, :destroy]
      collection do
        delete :bulk_destroy
      end
    end

    resources :registrations, only: [:index] do
      collection do
        delete :bulk_destroy
        get :export
      end
    end
  end
end
