class ProductsController < ApplicationController
  
  layout 'application'

  before_action :confirm_logged_in
  before_action :find_section, :find_preproduct

  def index
    @products = @preproduct.products.sorted
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new({:preproduct_id => @preproduct.id})
    @preproducts = Preproduct.order('ref_pre ASC')
    @colors = Color.order('ref_col ASC')
  end

  def create
    @product = Product.new(product_params)
    #guardamos el product
    if @product.save
      #Si se ha guardado, redirigimos a la página de listado de products del preproduct
      flash[:notice] = "Producto creado con éxito."
      redirect_to section_preproduct_products_path(@section.id, @product.preproduct_id)
    else
      # Si hay algún error, volvemos al formulario
      @preproducts = Preproduct.order('ref_pre ASC')
      @colors = Color.order('ref_col ASC')
      render('new')
    end
  end

  def edit
    @product = Product.find(params[:id])
    @preproducts = Preproduct.order('ref_pre ASC')
    @colors = Color.order('ref_col ASC')
  end

  def update
    # buscamos el product
    @product = Product.find(params[:id])
    # Actualizamos el product
    if @product.update_attributes(product_params)
      # Si se actualiza correctamente, redirigimos al listado de products del preproduct
      flash[:notice] = "Producto actualizado con éxito."
      redirect_to section_preproduct_products_path(@section.id, @product.preproduct_id)
    else
      # Si hay algún error, volvemos al formulario
      @preproducts = Preproduct.order('ref_pre ASC')
      @colors = Color.order('ref_col ASC')
      render('edit')
    end
  end

  def delete
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id]).destroy
    flash[:notice] = "Producto borrado con éxito."
    redirect_to section_preproduct_products_path(@section.id, @product.preproduct_id)
  end

  private

    def product_params
      params.require(:product).permit(:preproduct_id, :color_id, :titulo, :descripcion, :precio, :image)
    end

    def find_preproduct
      if params[:preproduct_id]
        @preproduct = Preproduct.find(params[:preproduct_id])
      end
    end

    def find_section
      if params[:section_id]
        @section = Section.find(params[:section_id])
      end
    end

end
