class CatalogoController < ApplicationController

  layout 'products'

  def index
  	@sections = Section.sorted

  	if params[:section_id]
  		@section = Section.find(params[:section_id])
  	else
  		@section = Section.first
  	end

    @products = Product.includes(:preproduct).where('preproducts.section_id' => @section.id).sorted.paginate(:page => params[:page], :per_page => 4)
    
    respond_to do |format|
      format.html
      format.js
    end

  end

  def show

    if params[:product_id] 
      @product = Product.find(params[:product_id])
      @products = Product.includes(:preproduct).where('preproducts.section_id' => @product.preproduct.section_id).sorted
      
      if @products.next(@product).first
        @next_product = @products.next(@product).first
      else
        @next_product = @products.first
      end

      if @products.previous(@product).last
        @previous_product = @products.previous(@product).last
      else
        @previous_product = @products.last
      end

    else
      redirect_to catalogo_index_path
    end

  end

end
