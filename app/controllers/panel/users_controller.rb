class Panel::UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to panel_users_path, :notice => "User successfully created!"
    else
      render :new
    end
    
  end
	

end
