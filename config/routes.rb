Blog::Application.routes.draw do
  resources :posts, only:[:show,:index,:new,:create,:edit,:update]
  resources :sections
  resources :tags
  root :to => 'posts#index'
end
