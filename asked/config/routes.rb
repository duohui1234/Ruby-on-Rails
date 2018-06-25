Rails.application.routes.draw do




  root 'posts#index'

  get 'users/index'
  get '/signup' => 'users#new'
  post 'users' => 'users#create'
  get '/users/:id/posts' => 'users#posts'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'


  resources :posts
    # get 'posts'  => 'posts#index'
    # get 'posts/new'
    # post 'posts' => 'posts#create'
    # get 'posts/:id'    => 'posts#show'
    # get 'posts/:id/edit'  => 'posts#edit'
    # put 'posts/:id'   => 'posts#update'
    # delete 'posts/:id'   => 'posts#destroy'





end
