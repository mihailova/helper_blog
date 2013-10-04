class TagsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_tag, only: [:show, :destroy, :edit, :update]

  def index
    @tags =  Tag.all.page(params[:page]).per(10)

  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)    
    if @tag.save
      redirect_to tags_path, notice:  "Tag has been successfully created."
    else
      render :new
    end
  end

  def show
    @posts = @tag.posts.page(params[:page]).per(10)
    @filter = Filter.new({tags: [@tag.id.to_s]} || {}, true)
    render "posts/index"
  end

  def edit
  end

  def update
    if @tag.update_attributes(tag_params)
      redirect_to tags_path, notice: 'Tag has been successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      redirect_to tags_path, notice: 'Tag has been successfully deleted.'
    end

  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      parameters = params.require(:tag).permit(:name)
    end

     
end
