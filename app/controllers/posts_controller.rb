class PostsController < ApplicationController
  def show
    @post = Post.find params[:id]
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.sections.build
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to @post, notice:created(:post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update_attributes post_params
      redirect_to @post, notice:updated(:post)
    else
      render :edit
    end
  end

  def post_params
    params.require(:post).permit :title, sections_attributes:[:content, :post_id, :tag_tokens, :id]
  end
end
