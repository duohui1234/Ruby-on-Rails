Rails.application.routes.draw do



  get 'users/index'
  get '/signup' => 'users#new'
  post 'users' => 'users#create'
  get '/login' => 'users#login'
  post '/loginprocess' => 'users#loginprocess'
  get '/logout' => 'users#logout'



  root 'posts#index'

  # get 'posts'  => 'posts#index'
  # get 'posts/new'
  # post 'posts' => 'posts#create'
  # get 'posts/:id'    => 'posts#show'
  # get 'posts/:id/edit'  => 'posts#edit'
  # put 'posts/:id'   => 'posts#update'
  # delete 'posts/:id'   => 'posts#destroy'

  resources :posts





end
