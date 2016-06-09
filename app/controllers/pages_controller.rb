class PagesController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject
  
  #displays list of items
  def index
    # @pages = Page.where(:subject_id => @subject.id).order('position ASC')
    @pages = @subject.pages.order("position ASC")
  end
  
  #displays single record
  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id,:name => "Tommy Trojan"})
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end

  def create
    #instantiate a new object form parameter
    @page = Page.new(page_params)

    #save the object
    if @page.save
      flash[:notice] = "Page Created Successfully!"
      redirect_to(:action => 'index',:subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:notice] = "Page Updated Successfully!"
      redirect_to(:action => 'show', :id => @page.id,:subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])    
  end

  def destroy
    page = Page.find(params[:id])    
    page.destroy
    flash[:notice] = "Page '#{page.name}' Destroyed Successfully!"
    redirect_to(:action => 'index',:subject_id => @subject.id)
  end

  private
    def page_params
      params.require(:page).permit(:name,:subject_id,:position,:visible,:permalink)
    end
    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end
end
