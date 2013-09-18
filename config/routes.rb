HelperBlog::Application.routes.draw do
  
  devise_for :users

  resources :pictures, only: :destroy
	resources :tags
  resources :posts do
  	collection do
 		get 'search'
  	end  
    resources :comments, except: [:index, :show]
  end

  root to: 'posts#index'
end
