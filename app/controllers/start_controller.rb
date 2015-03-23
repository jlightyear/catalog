class StartController < ApplicationController
  
  def new
    if Admin.sorted.first
      redirect_to(access_index_path)
    else
      @admin = Admin.new
    end
  end

  def create
    @admin = Admin.new(admin_params)
    #save the object
    if @admin.save
      #if save succeeds, redirect to the index action
      flash[:notice] = "Admin creado con éxito."
      redirect_to(access_index_path)
    else
      #if save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  private

  def admin_params
    params.require(:start).permit(:username, :email, :password, :password_confirmation, :active)
  end

end
