Blog::Application.routes.draw do
  resources :posts, only:[:show,:index,:new,:create,:edit,:update]
  resources :sections, only:[:show,:index,:new,:create,:edit,:update,:destroy]
  resources :tags, only:[:index,:show,:edit,:update,:destroy]
  root :to => 'posts#index'
end
