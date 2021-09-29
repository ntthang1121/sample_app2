Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
   root "static_pages#home"
   get "static_pages/help"
  end

  get "/users", to: "users#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  resources :users, only: %i(new create show)

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"


end
