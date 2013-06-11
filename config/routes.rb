Blog::Application.routes.draw do
  resources :posts, only:[:show,:index,:new,:create,:edit,:update]
  resources :sections
  resources :tags
  get 'tags/*id/edit' => 'tags#edit'
  get 'tags/*id' => 'tags#show'

  resources :users, only:[:new,:create,:edit,:update]

  root :to => 'posts#index'
end
