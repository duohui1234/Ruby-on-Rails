Rails.application.routes.draw do

  root 'posts#index'

  get 'posts/index'
  get 'posts/create'
  get 'posts/new'

  #restful 아키텍쳐
  get 'posts/:id'  => 'posts#show'
  get 'posts/:id/destroy' => 'posts#destroy'

  get 'posts/:id/edit'  => 'posts#edit'
  get 'posts/:id/update' =>'posts#update'

end
