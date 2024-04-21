Rails.application.routes.draw do
  root to: "static_pages#home"

  scope "/:lang/" do
    resources :lessons, except: :destroy
    resources :exercises, only: [:index, :show, :new, :create]
    resources :wordlist_exercises, except: :destroy
    resources :exercise_words
  end

  devise_for :users,
    skip: [:sessions],
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
      confirmations: "users/confirmations"
    }

  devise_scope :user do
    get "login", to: "devise/sessions#new", as: :new_user_session
    post "login", to: "devise/sessions#create", as: :user_session
    get "logout", to: "devise/sessions#destroy", as: :destroy_user_session
    get "welcome", to: "users/confirmations#welcome"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
