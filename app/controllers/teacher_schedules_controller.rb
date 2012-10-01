class TeacherSchedulesController < ApplicationController
	def index
		@teacherschedules = TeacherSubject.all
	end

	def show
		@teacherschedule = TeacherSubject.find(params[:id])
	end

	def new
		@teacherschedule = TeacherSubject.new
	end

	def create
		@teacherschedule = TeacherSubject.create(params[:teacherschedule])
		if @teacherschedule.save
			redirect_to teacher_schedules_path, :notice => "Successfull Created!!"
		else
			render :new
		end
	end

	def edit
		@teacherschedule = TeacherSubject.find(params[:id])		
	end

	def update 
		@teacherschedule = TeacherSubject.find(params[:id])
		if @teacherschedule.update_attributes(params[:teacherschedule])
			redirect_to teacher_schedules_path, :notice => "Successfully Updated!!"
		else
			render :edit
		end
	end

	def destroy
		@teacherschedule =TeacherSubject.find(params[:id])
		@teacherschedule.destroy
		redirect_to teacherschedule_schdedules_path, :notice => "Successfully Deleted!!"
	end

	def fullname
   	 "#{firstname} #{lastname}"
 	 end

end
