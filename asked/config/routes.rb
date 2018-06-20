Rails.application.routes.draw do


  root 'posts#index'

  get 'posts/index'   => 'posts#index'
  get 'posts/new'    => 'posts#new'
  get 'posts/create'
  
  get 'posts/:id/show'    => 'posts#show'
  get 'posts/:id/edit'  => 'posts#edit'
  get 'posts/:id/update'   => 'posts#update'
  get 'posts/:id/destroy'   => 'posts#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
