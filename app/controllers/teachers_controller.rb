class TeachersController < ApplicationController
	def index
		#@teachers = Teacher.all

		#@teachers = Teacher.order('firstname').page(params[:id]).per(10)

		# if @teacher.teacher_id = current_teacher_id

		# 	@teachers = @teacher.all ('create_at DESC').paginate(per_page: 1, params[:page])
		# else
		# 	@teachers = current_teacher.teachers(teacher: @teacher, page: params[:page])
		# end
		
		 @teachers = Teacher.search(params[:search_by], params[:search]).page(params[:page]).per(10)
		
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
