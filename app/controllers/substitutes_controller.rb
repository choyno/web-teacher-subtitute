  class SubstitutesController < ApplicationController
  
  def index
  	@substitutes = Substitute.all
  end
  
  def show
    @substitute = Substitute.find(params[:id])
  end
  
  def new
    @substitute = Substitute.new
  end


  def create
    @substitute = Substitute.create(params[:substitute])
    
    if @substitute.save
      redirect_to substitutes_path, :notice => "Request successfully created!"
    else
      render :new
    end
  end

  def edit
    @substitute = Substitute.find(params[:id]) 
  end

  def update
    @substitute = Substitute.find(params[:id])
    if @substitute.update_attributes(params[:substitute])
      redirect_to substitutes_path, :notice => "Request Successfully Updated"
    else
      render :edit      
    end
  end

  def destroy
    @substitute = Substitute.find(params[:id])
    @substitute.destroy
    redirect_to substitutes_path, :notice => "Request Successfully Deleted" 
  end

end