class SubjectsController < ApplicationController
  
  def index
    @subjects = Subject.search(params[:search_by], params[:search]).page(params[:page]).per(10)
  end

  def show
  	@subject = Subject.find(params[:id])
  end

  def new
	@subject = Subject.new	
  end

  def create
   	@subject = Subject.create(params[:subject])

   	if @subject.save
   		redirect_to subjects_path, notice: "Subject Successfully Added"
   	else
   		render :new
   	end
  end

  def edit
  	@subject = Subject.find(params[:id])
  end

  def update
  	@subject = Subject.find(params[:id])

  	if @subject.update_attributes(params[:subject])
  		redirect_to subjects_path, notice: "Subject Successfully Updated"
  	else
  		render :edit
  	end

  end

  def destroy
  		@subject = Subject.find(params[:id])
  		@subject.destroy

  		redirect_to subjects_path, notice: "Subject Successfully Deleted"
  end

end
