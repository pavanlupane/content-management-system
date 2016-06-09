class SectionController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  
  def index
    @sections = Section.order("position ASC")
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:name => "Tommy Trojan"})
    @pages = Page.order('position ASC')
    @section_count = Section.count + 1
  end

  def create
    #Instantiate a new object using form parameter
    @section = Section.new(section_params)
    #Save the object
    if @section.save
      #if save succeeds, redirect to the index action
      flash[:notice] = "Section Created Successfully!"
      redirect_to(:action => 'index')
    else
      #If save fails, redisplay the form so user can fix problems
      @pages = Page.order('position ASC')
      @section_count = Section.count + 1
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    #Find an existing object using form parameter
    @section = Section.find(params[:id])
    
    #Update the object
    if @section.update_attributes(section_params)
      #if update succeeds, redirect to the index action
      flash[:notice] = "Subject Updated Successfully!"
      redirect_to(:action => 'show', :id => @section.id)
    else
      #If update fails, redisplay the form so user can fix problems
      @pages = Page.order('position ASC')
      @section_count = Section.count
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id])
    section.destroy
    flash[:notice] = "Section '#{section.name}' Destroyed Successfully!"
    redirect_to(:action => 'index')
  end

  private
    def section_params
      params.require(:section).permit(:name, :page_id, :position,:visible,:content_type, :content)
    end
end
