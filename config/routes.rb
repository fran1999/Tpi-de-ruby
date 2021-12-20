Rails.application.routes.draw do

  resources :users
  get 'export_all', to: "export#export_all"
  resources :professionals do
    resources :appointments
    get 'export_appointments', to: "export#export_professional"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
