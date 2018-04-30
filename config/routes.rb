Rails.application.routes.draw do
  resources :sudachi_images
  resources :replay_msgs
  root to: 'replay_msgs#index'
  post '/callback' => 'linebot#callback'
end
