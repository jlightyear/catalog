class AdminsController < ApplicationController
  
  before_action :confirm_logged_in

  def index
    if !session[:super_admin]
      redirect_to(access_index_path)
    end
    #we don't want the first admin (superadmin)
    @admins = Admin.sorted[1..Admin.all.size]
  end

  def show
    redirect_to(access_index_path)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    #save the object
    if @admin.save
      #if save succeeds, redirect to the index action
      flash[:notice] = "Admin creado con éxito."
      redirect_to(admins_path)
    else
      #if save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    #find the admin
    @admin = Admin.find(params[:id])
    #Update the object
    if @admin.update_attributes(admin_params)
      #if update succeeds, redirect to the index action
      flash[:notice] = "Admin User updated successfully."
      redirect_to(admins_path)
    else
      #if update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @admin.find(params[:id])
  end

  def destroy
    @admin = Admin.find(params[:id]).destroy
    flash[:notice] = "Admin '#{@admin.username}' destroyed successfully."
    redirect_to(admins_path)
  end

  private

  def admin_params
    params.require(:admin).permit(:username, :email, :password, :password_confirmation, :active)
  end

end
