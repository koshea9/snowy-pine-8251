Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :flights, only: [:index]
  delete "flights/:flight_id/passengers", to: "manifests#destroy", as: "manifest_destroy"
end
