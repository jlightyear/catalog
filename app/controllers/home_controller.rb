class HomeController < ApplicationController
  
  layout 'products'

  def index
  	common_variable_sections
  end

  private

  def common_variable_sections
    @sections = Section.sorted
  end
  
end
