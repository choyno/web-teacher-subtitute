class SectionsController < ApplicationController
  def index
  	@sections = Section.all
    @sections = Section.page(params[:page]).per(10)
  end

  def show
  	@section = Section.find(params[:id])
  end

  def new
  	@section = Section.new
  end

  def create
  	@section = Section.create(params[:section])
  	if @section.save
  		redirect_to sections_path, notice: "Section is Succesfull added!!"
  	else
  		render :new
    end
  end

  def edit
  	@section = Section.find(params[:id])
  end

  def update
  	@section = Section.find(params[:id])
  	if @section.update_attributes(params[:section])
  		redirect_to sections_path, notice: "Section Successfully Updated"
  	else
  		render :edit
  	end
  end

  def destroy
  	@section = Section.find(params[:id])
  	@section.destroy
  	redirect_to sections_path, notice: "Successfully Deleted"
  end
end
