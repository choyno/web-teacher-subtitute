class DaycodesController < ApplicationController
  def index
  	@daycodes = DayCode.all
    @daycodes = DayCode.page(params[:page]).per(10)
  end

  def show
  	@daycode = DayCode.find(params[:id])
  end

  def new
  	@daycode = DayCode.new(params[:id])
  end

  def create
  	@daycode = DayCode.new(params[:day_code])	

  	if @daycode.save
  		redirect_to daycodes_path, :notice => "Day Types Sucessfully Created!"
  	else
  		render :new
  	end
  end

  def edit
    @daycode = DayCode.find(params[:id])
  end

  def update
     @daycode  = DayCode.find(params[:id])

    if @daycode.update_attributes(params[:day_code])
          redirect_to daycodes_path, :notice => "Day Types Sucessfully Updated!"
     else
      render :edit
    end
  end

  def destroy
    @daycode = DayCode.find(params[:id])
    @daycode.destroy

    redirect_to daycodes_path, :notice => "Sucessfully deleted!! "
    
  end

end
