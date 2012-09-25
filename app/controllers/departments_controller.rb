  class DepartmentsController < ApplicationController
  
  def index
    @departments = Department.all
  end
  
  def show
    @department = Department.find(params[:id])
  end
  
  def new 
    @department  = Department.new
  end

  def create
    @department  = Department.create(params[:department])
    
    if @department.save
      redirect_to departments_path, :notice => "Department successfully created!"
    else
      render :new
    end
    
  end
  
  def edit
    @department  = Department.find(params[:id]) 
  end
  
  def update
     @department  = Department.find(params[:id])
    if @department.update_attributes(params[:department])
      redirect_to departments_path, notice: "Department successfully updated"
    else
      render :edit
    end
  end
  
	def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to departments_path, notice: 'Department Deleted!'
  end

end
