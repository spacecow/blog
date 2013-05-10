class SectionsController < ApplicationController
  def show
    @section = Section.find params[:id]
  end

  def index
    @sections = Section.scoped
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new params[:section]
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
    if @section.update_attributes params[:section]
      redirect_to @section, notice:updated(:section)
    else
      render :edit
    end
  end

  def destroy
    @section = Section.find params[:id]
    section_url = section_url(@section)
    post_url = post_url(@section.post) if @section.post
    previous_url = request.env['HTTP_REFERER'] 
    @section.destroy
    if previous_url == section_url
      redirect_to sections_path
    elsif previous_url == post_url
      redirect_to post_url
    end
  end
end
