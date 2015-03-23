class SectionsController < ApplicationController
  
  before_action :confirm_logged_in

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    #guardamos la sección
    if @section.save
      #Si se guarda correctamente, redirigimos a index
      flash[:notice] = "Sección creada con éxito."
      redirect_to sections_path
    else
      #Si el guardar tiene algún error, volvemos a mostrar el formulario para solucionarlo
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    #encontrar sección
    @section = Section.find(params[:id])
    #actualizar sección
    if @section.update_attributes(section_params)
      #Si se actualiza correctamente, redirigimos a index
      flash[:notice] = "Sección actualizada con éxito."
      redirect_to sections_path
    else
      #Si el actualizar tiene algún error, volvemos a mostrar el formulario para solucionarlo
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end
    
  def destroy
    @section = Section.find(params[:id]).destroy
    flash[:notice] = "La sección '#{@section.titulo}' ha sido borrada con éxito."
    redirect_to sections_path
  end

  private

    def section_params
      params.require(:section).permit(:titulo, :titular, :ref_sec, :image)
    end

end
