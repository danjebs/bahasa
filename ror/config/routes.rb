Rails.application.routes.draw do
  root to: "static_pages#home"

  resources :courses, only: [:index, :show, :new, :create] do
    resources :lessons, shallow: true
  end

  resources :languages, only: [] do
    resources :journeys, shallow: true, only: [:create] do
      resources :decks, shallow: true, except: [:edit, :delete]
    end
  end

  resources :exercises
  resources :word_lists, except: [:new, :destroy], path: "word-lists"
  resources :phrase_lists, except: [:new, :destroy], path: "phrase-lists"
  resources :blurbs, except: [:destroy]
  resources :deck_cards, only: [:update], path: "deck-cards"
  resources :cards
  resources :translation_cards, except: [:destroy], path: "translation-cards"
  resources :phrases
  resources :words

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

  get "up" => "rails/health#show", as: :rails_health_check
end
