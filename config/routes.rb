HelperBlog::Application.routes.draw do
  devise_for :users

  resources :posts do
  	collection do
 		get 'search'
  	end
  end
  
  root to: 'posts#index'
end
