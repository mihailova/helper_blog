class PostsController < ApplicationController

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
  end

  private

    def post_params
      parameters = params.require(:post).permit(:title, :text, :tags, :private)
      parameters[:tags] = parameters[:tags].split(/[\s,]+/)
      parameters
    end
end
