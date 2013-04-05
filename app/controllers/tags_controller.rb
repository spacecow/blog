class TagsController < ApplicationController
  def index
    @tags = Tag.scoped
    respond_to do |format|
      format.json { render json:@tags.where('name like ?', "%#{params[:q]}%") }
    end
  end
end
