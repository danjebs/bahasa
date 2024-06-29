Rails.application.routes.draw do
  root to: "static_pages#home"

  devise_for :users,
    skip: [:sessions],
    controllers: {
      sessions: "users/sessions",
    }

  devise_scope :user do
    get "login", to: "devise/sessions#new", as: :new_user_session
    post "login", to: "devise/sessions#create", as: :user_session
    get "logout", to: "devise/sessions#destroy", as: :destroy_user_session
    get "welcome", to: "users/confirmations#welcome"
  end

  get "/journeys", to: "journeys#index"
  resources :journeys, path: "/", param: :lang, only: [:show]
  resources :deck_cards, only: [:update]

  scope "/:lang/" do
    resources :lessons
    resources :exercises
    resources :word_lists, except: [:new, :destroy]
    resources :phrase_lists, except: [:new, :destroy]
    resources :blurbs, except: [:destroy]
    resources :decks, except: [:edit, :update, :delete]
    resources :cards
    resources :translation_cards, except: [:destroy]
    resources :phrases
    resources :words
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
