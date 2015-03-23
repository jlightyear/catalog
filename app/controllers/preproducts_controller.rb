class PreproductsController < ApplicationController

  before_action :confirm_logged_in
  before_action :find_section

  def index
    @preproducts = @section.preproducts.sorted
  end

  def show
    @preproduct = Preproduct.find(params[:id])
  end

  def new
    @preproduct = Preproduct.new({:section_id => @section.id})
    @sections = Section.order('id ASC')
  end

  def create
    @preproduct = Preproduct.new(preproduct_params)
    #guardamos el preproduct
    if @preproduct.save
      #Si se ha guardado, redirigimos a la página de listado de preproducts de la categoría
      flash[:notice] = "Preproduct creado con éxito."
      redirect_to section_preproducts_path(@preproduct.section_id)
    else
      # Si hay algún error, volvemos al formulario
      @sections = Section.order('id ASC')
      render('new')
    end
  end

  def edit
    @preproduct = Preproduct.find(params[:id])
    @sections = Section.order('id ASC')
  end

  def update
    # buscamos el preproduct
    @preproduct = Preproduct.find(params[:id])
    # Actualizamos el preproduct
    if @preproduct.update_attributes(preproduct_params)
      # Si se actualiza correctamente, redirigimos al listado de preproducts de la categoría
      flash[:notice] = "Preproduct actualizado con éxito."
      redirect_to section_preproducts_path(@preproduct.section_id)
    else
      # Si hay algún error, volvemos al formulario
      @sections = Section.order('id ASC')
      render('edit')
    end
  end

  def delete
    @preproduct = Preproduct.find(params[:id])
  end

  def destroy
    @preproduct = Preproduct.find(params[:id]).destroy
    flash[:notice] = "Preproduct '#{@preproduct.titulo}' borrado con éxito."
    redirect_to section_preproducts_path(@preproduct.section_id)
  end

  private

    def preproduct_params
      params.require(:preproduct).permit(:section_id, :titulo, :descripcion, :precio, :ref_pre)
    end

    def find_section
      if params[:section_id]
        @section = Section.find(params[:section_id])
      end
    end
end
