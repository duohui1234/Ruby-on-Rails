Rails.application.routes.draw do




  root 'posts#index'


  get 'comments/new'
  get 'comments/create'



  resources :posts

  # get 'posts' => 'posts#index'
  # get 'posts/new' => 'posts#new'
  # post 'posts' => 'posts#create'
  #
  # get 'posts/:id' => 'posts#show'
  # get 'posts/:id/edit' => 'posts#edit'
  # put 'posts/:id'  => 'posts#update'
  # delete 'posts/:id' => 'posts#destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
