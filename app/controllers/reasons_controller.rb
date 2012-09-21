class ReasonsController < ApplicationController
  def index
  	@reasons = Reason.all
  end

  def show
  	@reason = Reason.find(params[:id])
  end

  def new
  	@reason = Reason.new
  end

  def create
  	@reasons = Reason.create(:params[:reason])

  	if @reason.save
  		redirect_to reasons_path, notice: "Absent Reasons is Successfully Added!"
  	else
  		render :new
  	end

  end

  def edit
  	@reason = Reason.find(params[:id])

  end

  def update
  	@reason = Reason.find(params[:id])

  	if @reason.update_attributes(params[:reason])
  		redirect_to reasons_path, notice: "Absent Reasons is Successfully Updated!"
  	else
  		render :edit
  	end

  end

  def destroy
  	@reason = Reason.find(params[:id])
  	@reason.destroy

  	redirect_to reasons_path, notice: "Successfully Deleted!!"

  end

end
