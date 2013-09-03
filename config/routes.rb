NHLTracker::Application.routes.draw do
  resources :players
  resources :games

  root to: "players#index"
end
