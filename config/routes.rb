Rails.application.routes.draw do
  get 'game', to: 'longestwords#game'
  get 'score', to: 'longestwords#score'
  post '/score', to: 'longestwords#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
