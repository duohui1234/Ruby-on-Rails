Rails.application.routes.draw do


  get 'users/create'
  get 'users/index'


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
