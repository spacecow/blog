class PostsController < ApplicationController
  def show
    @post = Post.find params[:id]
  end

  def index
    @posts = Post.scoped
  end

  def new
    @post = Post.new
    @post.sections.build
  end

  def create
    @post = Post.new params[:post]
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
    if @post.update_attributes params[:post]
      redirect_to @post, notice:updated(:post)
    else
      render :edit
    end
  end
end
