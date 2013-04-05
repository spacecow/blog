Blog::Application.routes.draw do
  resources :posts, only:[:show,:new,:create,:edit,:update]
  resources :tags, only: :index
  root :to => 'posts#new'
end
