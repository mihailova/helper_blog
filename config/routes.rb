HelperBlog::Application.routes.draw do
  devise_for :users

  resources :posts do
  	collection do
 		get 'search'
 		get 'tags'
  	end
  end

  get 'posts/serach_by_tag/:tag' => 'posts#serach_by_tag', as: "posts_serach_by_tag"

  root to: 'posts#index'
end
