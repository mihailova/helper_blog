class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new

    if @post.update_attributes(post_params)
      redirect_to post_path(@post), notice:  "Post has been successfully created."
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post.private && !user_signed_in?
      redirect_to new_user_session_path, notice: "Have to login to see private posts"
    end
  end

  private

    def post_params
      parameters = params.require(:post).permit(:title, :text, :tags, :private)
      parameters[:tags] = parameters[:tags].split(/[\s,]+/) if parameters[:tags].kind_of? String 
      parameters
    end
end
