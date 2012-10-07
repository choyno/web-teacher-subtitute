class TeacherSchedulesController < ApplicationController
	
	def index
		@teacher_subjects = TeacherSubject.search(params[:search]).page(params[:page]).per(10)
	end

	def show
		@teacher_subject = TeacherSubject.find(params[:id])
	end

	def new
		@teacher_subject = TeacherSubject.new
	end

	def create
		@teacher_subject = TeacherSubject.create(params[:teacher_subject])
		if @teacher_subject.save
			redirect_to teacher_schedules_path, notice: "Successfull Created!!"
		else	
			render :new
		end
	end

	def edit
		@teacher_subject = TeacherSubject.find(params[:id])		
	end

	def update 
		@teacher_subject = TeacherSubject.find(params[:id])
		if @teacher_subject.update_attributes(params[:teacher_subject])
			redirect_to teacher_schedules_path, notice: "Successfully Updated!!"
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
