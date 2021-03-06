class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :search, :sort]

  def index
    @posts = Post.filter(params[:filter] || {}).sort_by(params[:sort]).page(params[:page]).per(10)
    @filter = Filter.new(params[:filter] || {}, true, current_user.try(:id))
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
    @comment = Comment.new
    if @post.private && !user_signed_in?
      redirect_to new_user_session_path, notice: "Have to login to see private posts"
    end
  end

  def edit
    @post = Post.find(params[:id])

    @post.canEdit?(current_user) or return render :show

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

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to root_path, notice: 'Post has been successfully deleted.'
    end

  end

  def search
    @posts = Kaminari.paginate_array(Post.searchAll(params[:search])).page(params[:page]).per(10)
    @filter = Filter.new({}, true, current_user.try(:id))
    render :index
  end

  private

    def post_params
      parameters = params.require(:post).permit(:title, :text, :tags, :private, :can_modify, {tag_ids: []}, :pictures_attributes => [:caption, :image] )
    end

     
end
