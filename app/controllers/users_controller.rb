class UsersController < ApplicationController
    
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    session[:user_id] = @user.id
    
    if @user.save
      redirect_to users_path, :notice => "User successfully created!"
    else
      render :new
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: "User successfully updated"
    else
      render :edit
    end
    
  end
  
	

end