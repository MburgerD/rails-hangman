Rails.application.routes.draw do
  resources :games
  root 'hangman#show'
end
