class DemoController < ApplicationController
  
  layout 'application'
  
  def index
  	#render('hello')

  end

  def hello
  	#render('index')
  	@array = [1,2,3,4,5]
  	@id = params['id']
  	
  end

  def other_hello
  	redirect_to(:controller => 'demo' , :action => 'index')
  end

  def pavan
  	redirect_to(  'http://www.pavanlupane.com')
  end

  def text_helpers

  end

end
