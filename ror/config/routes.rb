Rails.application.routes.draw do
  root to: "static_pages#home"

  scope "/:lang/" do
    resources :lessons
    resources :exercises, only: [:index, :new, :create, :update, :destroy]
    resources :wordlist_exercises, only: [:index, :create, :edit, :update]
    resources :cards
    resources :translation_cards, except: [:destroy]
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
