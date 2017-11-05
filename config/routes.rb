Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'notes#index'
  post '/', to: 'notes#create', as:"notes"
  get '/:slug', to: 'notes#show'
  get '/:slug/info', to: 'notes#info'
  post '/messages/api', to: 'notes#create'
end
