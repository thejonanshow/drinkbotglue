Rails.application.routes.draw do
  resources :beverages
  resources :motors
  get "/beverages/status/:id", to: "beverages#status"
  post "/beverages/dispense", to: "beverages#dispense"
  post "/motors/find", to: "motors#find"
end
