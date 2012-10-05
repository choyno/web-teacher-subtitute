class TeacherSchedulesController < ApplicationController
	def index
		@teachersubjects = TeacherSubject.all 
	end

	def show
		@teachersubject = TeacherSubject.find(params[:id])
	end

	def new
		@teachersubject = TeacherSubject.new
	end

	def create
		@teachersubject = TeacherSubject.create(params[:teachersubject])
		if @teachersubject.save
			redirect_to teacher_schedules_path, notice: "Successfull Created!!"
		else	
			render :new
		end
	end

	def edit
		@teachersubject = TeacherSubject.find(params[:id])		
	end

	def update 
		@teachersubject = TeacherSubject.find(params[:id])
		if @teachersubject.update_attributes(params[:teachersubject])
			redirect_to teacher_schedules_path, :notice => "Successfully Updated!!"
		else
			render :edit
		end
	end

	def destroy
		@teachersubject =TeacherSubject.find(params[:id])
		@teachersubject.destroy
		redirect_to teacher_schedules_path, :notice => "Successfully Deleted!!"
	end

	def fullname
   	 "#{firstname} #{lastname}"
 	 end

end
