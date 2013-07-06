HelperBlog::Application.routes.draw do
  devise_for :users

  resources :posts
end
