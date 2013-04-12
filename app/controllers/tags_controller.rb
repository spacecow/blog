class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def index
    @tags = Tag.scoped
    respond_to do |format|
      format.html
      format.json { render json:@tags.  tokens(params[:q]) }
    end
  end

  def edit
    @tag = Tag.find params[:id]
  end

  def update
    @tag = Tag.find params[:id]
    if @tag.update_attributes params[:tag]
      redirect_to @tag, notice:updated(:tag)
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find params[:id]
    @tag.destroy
    redirect_to tags_path, notice:deleted(:tag)
  end
end
