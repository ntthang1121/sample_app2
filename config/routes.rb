Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "static_pages#home"
    get "static_pages/help"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end

  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(show index destroy)
  resources :microposts, only: %i(create destroy)
end
