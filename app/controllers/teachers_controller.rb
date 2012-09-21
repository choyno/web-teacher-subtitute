class TeachersController < ApplicationController
	def index
		@teachers = Teacher.all
	end

	def show
		@teacher = Teacher.find(params[:id])
	end

	def new	
		@teacher = Teacher.new
	end

	def create
		@teacher = Teacher.new(params[:teacher])

		if @teacher.save
			redirect_to teachers_path, notice: "Teacher Successfully Added"
		else
			render :new
		end
	end

	def edit
		@teacher = Teacher.find(params[:id])	
	end

	def update
		@teacher = Teacher.find(params[:id])

		if @teacher.update_attributes(params[:teacher])
			redirect_to teachers_path, notice: "Teacher Successfully Updated"
		else
			render :edit
		end
	end

	def destroy
	    @teacher = Teacher.find(params[:id])
	    @teacher.destroy

	    redirect_to teachers_path, notice: 'Teacher Deleted!'
  	end

end