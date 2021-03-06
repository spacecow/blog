class TagsController < ApplicationController
  def show
    @tag = Tag.find params[:id]
  end

  def index
    @tags = Tag.all
    respond_to do |format|
      format.html
      format.json { render json:@tags.  tokens(params[:q]) }
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new tag_params
    if @tag.save
      redirect_to @tag, notice:created(:tag) 
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find params[:id]
  end

  def update
    @tag = Tag.find params[:id]
    if @tag.update tag_params
      redirect_to @tag, notice:updated(:tag)
    else
      render :edit
    end
  end

  def destroy
    p "DELETE!!!"
    @tag = Tag.find params[:id]
    @tag.destroy
    redirect_to tags_url, notice:deleted(:tag)
  end

  def tag_params
    params.require(:tag).permit :leaf_name, :parent_id
  end
end
