Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/gate', to: 'gate#confirm'
  post '/authenticate', to: 'authentication#authenticate'
end
