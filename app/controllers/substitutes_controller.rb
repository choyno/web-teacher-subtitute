  class SubstitutesController < ApplicationController
  
  def index

    @substitutes = Substitute.request_type_planned.search(params[:search]).page(params[:page]).per(10)
   end
  
  def show
    @substitute = Substitute.find(params[:id])
  end
  
  def new
    @substitute = Substitute.new
  end

  def create
    # sub_teacher_id"=>"151", "teacher_subject_id"=>"18", "planned"=>"true", "date_substitute"=>"", "reason_id"=>"1", "notes"=>""
        
    @substitute = Substitute.new({ substitute_teacher_id: params[:sub_teacher_id],
                                   teacher_subject_id: params[:teacher_subject_id],
                                   planned: params[:planned],
                                   reasons_id: params[:reason_id],
                                   assigned_by_user_id: current_user.id
                                })    
    @substitute.status = 'Substitute'
   
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
  
  
  def load_teacher_subject
    teacher = Teacher.find(params[:teacher_id])
    @subjects = teacher.teacher_subjects.includes(:subject, :day_code)
    
  end
  
  def load_sub_teacher_subjects
    teacher = Teacher.find(params[:sub_teacher_id])
    @subjects = teacher.teacher_subjects.includes(:subject, :day_code)
  end
  
  
  
  
  
  # def load_available_teachers
  #     # get info for time and daycode and subject
  #     teacher_subject = TeacherSubject.find(params[:teacher_subject_id])
  #     
  #     not_available_teachers = TeacherSubject.select('teacher_id')
  #                                            .where("teacher_id != ?", teacher_subject.teacher_id)
  #                                            .where("time_start = ?", teacher_subject.time_start)
  #                                            .pluck(:teacher_id)
  #                                            
  #      @available_teachers = TeacherSubject.where("teacher_id NOT IN(?)", not_available_teachers )                                      
  #                                         .default_include
  #                                         .order('teachers.lastname')
  #   end
  
  
  

end
