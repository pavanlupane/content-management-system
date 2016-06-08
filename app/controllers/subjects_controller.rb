class SubjectsController < ApplicationController
  
  layout "admin"

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Tommy Trojan"})
    @subject_count = Subject.count + 1
  end

  def create
    #Instantiate a new object using form parameter
    @subject = Subject.new(subject_params)
    #Save the object
    if @subject.save
      #if save succeeds, redirect to the index action
      flash[:notice] = "Subject Created Successfully!"
      redirect_to(:action => 'index')
    else
      #If save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
    
  end

  def update
    #Find an existing object using form parameter
    @subject = Subject.find(params[:id])
    
    #Update the object
    if @subject.update_attributes(subject_params)
      #if update succeeds, redirect to the index action
      flash[:notice] = "Subject Updated Successfully!"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      #If update fails, redisplay the form so user can fix problems
      @subject_count = Subject.count
      render('edit')
    end
  end


  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id])
    subject.destroy
    flash[:notice] = "Subject '#{subject.name}' Destroyed Successfully!"
    redirect_to(:action => 'index')
    
  end

  private
    def subject_params
      params.require(:subject).permit(:name, :position,:visible)
    end
end
