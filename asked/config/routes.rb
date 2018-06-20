Rails.application.routes.draw do


  root 'posts#index'

  get 'posts/index'
  get 'posts/new'
  post 'posts/create'

  get 'posts/:id'    => 'posts#show'
  get 'posts/:id/edit'  => 'posts#edit'
  put 'posts/:id'   => 'posts#update'
  delete 'posts/:id'   => 'posts#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
