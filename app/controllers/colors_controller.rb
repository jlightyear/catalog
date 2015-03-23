class ColorsController < ApplicationController
  
  before_action :confirm_logged_in
  
  def index
    @colors = Color.sorted
  end

  def show
    @color = Color.find(params[:id])
  end

  def new
    @color = Color.new
  end

  def create
    @color = Color.new(color_params)
    #guardamos el color
    if @color.save
      #Si se guarda correctamente, redirigimos a index
      flash[:notice] = "Color creado con éxito."
      redirect_to colors_path
    else
      #Si el guardar tiene algún error, volvemos a mostrar el formulario para solucionarlo
      render('new')
    end
  end

  def edit
    @color = Color.find(params[:id])
  end

  def update
    #encontrar color
    @color = Color.find(params[:id])
    #actualizar color
    if @color.update_attributes(color_params)
      #Si se actualiza correctamente, redirigimos a index
      flash[:notice] = "Color actualizado con éxito."
      redirect_to colors_path
    else
      #Si el actualizar tiene algún error, volvemos a mostrar el formulario para solucionarlo
      render('edit')
    end
  end

  def delete
    @color = Color.find(params[:id])
  end
    
  def destroy
    @color = Color.find(params[:id]).destroy
    flash[:notice] = "El color '#{@color.color}' ha sido borrado con éxito."
    redirect_to colors_path
  end

  private

    def color_params
      params.require(:color).permit(:color, :ref_col)
    end
end
