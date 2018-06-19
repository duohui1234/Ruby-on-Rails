Rails.application.routes.draw do

  root 'post#index'
  get 'post/index'  => 'post#index'
  get 'post/new'   => 'post#new'
  get 'post/create' => 'post#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
