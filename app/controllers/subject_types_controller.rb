class SubjectTypesController < ApplicationController
  def index
  	@subject_types = SubjectType.all
  end

  def show
  	@subject_type = SubjectType.find(params[:id])
  end

  def new
  	@subject_type = SubjectType.new
  end

  def create
  	@subject_type = SubjectType.create(params[:subject_type])
  	if @subject_type.save
  		redirect_to subject_types_path, notice: "Successfully Saved!!"
  	else
  		render :new
  	end
  end

  def edit
  	@subject_type = SubjectType.find(params[:id])	
  end

  def update
  	@subject_type = SubjectType.find(params[:id])
  	if @subject_type.update_attributes(params[:subject_type])
  		redirect_to subject_types_path, notice: "Successfully Updated!!"
  	else
  		render :edit
    end
  end

  def destroy
  	@subject_type = SubjectType.find(params[:id])
  	@subject_type.destroy
  		redirect_to subject_types_path, notice: "Successfully Deleted"
  end


end
