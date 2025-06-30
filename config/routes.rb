Rails.application.routes.draw do
  root "messages#index"
  resources :messages, only: [ :index, :create ]
  resources :players
  post "roll_dice", to: "messages#roll_dice", as: "roll_dice"
end
