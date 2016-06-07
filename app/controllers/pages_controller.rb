class PagesController < ApplicationController
  
  layout false

  #displays list of items
  def index
    @pages = Page.order("position ASC")
  end
  
  #displays single record
  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:name => "Tommy Trojan"})
  end

  def create
    #instantiate a new object form parameter
    @page = Page.new(page_params)

    #save the object
    if @page.save
      flash[:notice] = "Page Created Successfully!"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:notice] = "Page Updated Successfully!"
      redirect_to(:action => 'show', :id => @page.id)
    else
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
    redirect_to(:action => 'index')
  end

  private
    def page_params
      params.require(:page).permit(:name,:subject_id,:position,:visible,:permalink)
    end
end
