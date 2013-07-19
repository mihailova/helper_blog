class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new
    current_user.changed_posts << @post

    if @post.update_attributes(post_params)
      redirect_to post_path(@post), notice:  "Post has been successfully created."
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post.private && !user_signed_in?
      redirect_to new_user_session_path, notice: "Have to login to see private posts"
    end
  end

  def edit
    @post = Post.find(params[:id])

    unless @post.can_modify || @post.user == current_user
        render :show 
    end

  end

  def update
    @post = Post.find(params[:id])
    current_user.changed_posts << @post

    if @post.update_attributes(post_params)
      redirect_to post_path(@post), notice: 'Post has been successfully updated.'
    else
      render :edit
    end
  end

  private

    def post_params
      parameters = params.require(:post).permit(:title, :text, :tags, :private, :can_modify)
      parameters[:tags] = parameters[:tags].split(/[\s,]+/) if parameters[:tags].kind_of? String 
      parameters
    end
end
