Rails.application.routes.draw do
  resources :replay_msgs
  root to: 'replay_msgs#index'
  post '/callback' => 'linebot#callback'
end
