class SectionsController < ApplicationController
  def show
    @section = Section.find params[:id]
  end

  def index
    @sections = Section.all
  end

  def new
    @section = Section.new
    @section.tags << Tag.find_by(name:params[:tag_name]) if params[:tag_name]
  end

  def create
    @section = Section.new section_params
    if @section.save
      redirect_to @section, notice:created(:section)
    else
      render :new
    end
  end

  def edit
    @section = Section.find params[:id]
  end

  def update
    @section = Section.find params[:id]
    if @section.update_attributes section_params
      redirect_to @section, notice:updated(:section)
    else
      render :edit
    end
  end

  def destroy
    @section = Section.find params[:id]
    section_url = section_url(@section)
    previous_url = request.env['HTTP_REFERER'] 
    @section.destroy
    if previous_url == section_url
      redirect_to sections_path
    else
      redirect_to :back
    end
  end

  def section_params
  #attr_accessible :content, :tag_tokens, :post_id
    params.require(:section).permit :content, :tag_tokens, :post_id
  end
end
