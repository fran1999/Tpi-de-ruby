Rails.application.routes.draw do
  #Home de la app
  root to: 'home#index' 

  #rutas relacionadas a sesiones
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"


  #rutas de usuario
  resources :users

  resources :users
  get 'export_all', to: "export#export_all"
  resources :professionals do
    resources :appointments
    get 'export_appointments', to: "export#export_professional"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
