class RoomsController < ApplicationController
  def index
  	@rooms = Room.all
    @rooms = Room.page(params[:page]).per(10)
  end

  def show	
  	@room = Room.find(params[:id])
  end

  def new
  	@room = Room.new
  end

  def create
  	@room = Room.create(params[:room])
  	if @room.save
  			redirect_to rooms_path, notice: "Room Number Succcesfully Added!!"
  	else
  		render :new
  	end
  end

  def edit
 	@room = Room.find(params[:id])
  end

  def update
  	@room = Room.find(params[:id])
  	if @room.update_attributes(params[:room])
  		redirect_to rooms_path, notice: "Room Number Succcesfully Updated"
  	else
  		render :edit
  	end
  end

  def destroy
  	@room = Room.find(params[:id])
  	@room.destroy
  	redirect_to rooms_path, notice: "Succcesfully Deleted"
  end

end
	