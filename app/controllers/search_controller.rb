class SearchController < ApplicationController

  layout 'products'
  
  def index
    @sections = Section.sorted
    
    if(params.has_key?(:searchbox))
      @products = Product.search(params[:searchbox])
    else
      redirect_to catalogo_index_path
    end
  end

  def show
    if params[:product_id] 
      @product = Product.find(params[:product_id])
    else
      redirect_to catalogo_index_path
    end
  end

end
