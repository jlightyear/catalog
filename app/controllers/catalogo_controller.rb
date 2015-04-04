class CatalogoController < ApplicationController

  layout 'products'

  def index
  	common_variable_sections

  	#operador ternario
    @section = params[:section_id] ? Section.find(params[:section_id]) : Section.first

    @products = Product.includes(:preproduct).where('preproducts.section_id' => @section.id).sorted.paginate(:page => params[:page], :per_page => 4)
    
    respond_to do |format|
      format.html
      format.js
    end

  end

  def show
    common_variable_sections

    if params[:product_id] 
      @product = Product.find(params[:product_id])
      @products = Product.includes(:preproduct).where('preproducts.section_id' => @product.preproduct.section_id).sorted
      
      @next_product = @products.next(@product).first ? @products.next(@product).first : @products.first
      @previous_product = @products.previous(@product).last ? @products.previous(@product).last : @products.last
    else
      redirect_to catalogo_index_path
    end

  end

end
