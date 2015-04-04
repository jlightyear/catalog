class AccessController < ApplicationController
  
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
    # menu for admins
  end

  def login
    if session[:admin_username]
      redirect_to(access_index_path)
    end

    if !Admin.sorted.first
      redirect_to(start_new_path)
    end
    # login form
  end

  def attempt_login

    if Admin.sorted.first
      @primer_admin = Admin.sorted.first
    end

    if params[:username].present? && params[:password].present?
      # comprobar que el admin este activo
      found_user = Admin.where(:username => params[:username]).active.first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      # mark admin as logged in
      session[:admin_id] = authorized_user.id
      session[:admin_username] = authorized_user.username

      # mark admin like super_admin
      if authorized_user.id == @primer_admin.id
        session[:super_admin] = true
      end
      
      flash[:notice] = "Estás logueado."
      redirect_to(access_index_path)
    else
      flash[:alert] = "Combinación de usuario/password inválida."
      redirect_to(access_login_path)
    end

  end

  def logout
    # mark admin as logged out
    session[:admin_id] = nil
    session[:admin_username] = nil
    if session[:super_admin]
      session[:super_admin] = nil
    end
    flash[:alert] = "Logged out."
    redirect_to(access_login_path)
  end

end
