class HomeController < ApplicationController
  
  layout 'products'

  def index
  	@sections = Section.sorted
  end
  
end
