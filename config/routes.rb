Rails.application.routes.draw do
  root "messages#index"
  resources :messages, only: [ :index, :create ]
  resources :players do
    resource :character_sheet
  end
  resources :articles
  post "roll_dice", to: "messages#roll_dice", as: "roll_dice"
  post "set_current_player", to: "messages#set_current_player", as: "set_current_player"
end
