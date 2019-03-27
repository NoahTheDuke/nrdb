Rails.application.routes.draw do
  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/cards', to: 'static_pages#cards'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
end
