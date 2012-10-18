class SubstitutesController < ApplicationController
  
  def index

    @substitutes = Substitute.request_type_planned.status_is_substitute.search(params[:search_by],params[:search]).page(params[:page]).per(10)
   end
  
  def show
    @substitute = Substitute.find(params[:id])
  end
  
  def new
    @substitute = Substitute.new
  end

  def create
    # { "utf8"=>"✓", "authenticity_token"=>"4GpSZ/8OvQinBB45RyN8H0RJfecH/8vJLmLXOjMW5O4=", 
    #   "planned"=>"false", "absent_teacher"=>"1", 
    #   "teacher_schedule_id"=>["17", "966", "776", "1348", "1", "129", "193", "177", "201", "924", "948", "978", "105"], 
    #   "available_teacher"=>["78", "", "", "", "", "", "", "", "", "", "", "", ""], "reason"=>"1", 
    #   "notes"=>"", "request_at_from"=>"10/15/2012", "request_at_to"=>"10/19/2012" }
    
    
        
    @substitute = Substitute.new({ request_at_from: params[:request_at_from],
                                   request_at_to: params[:request_at_to],
                                   planned: params[:planned],
                                   reason_id: params[:reason],
                                   teacher_id: params[:absent_teacher],
                                   assigned_by_user_id: current_user.id
                                })
                                    
    if params[:planned] == "false"
            @substitute.status = 'Pending Substitute'
    else
            @substitute.status = 'Need to Confirm Substitute'
    end
    
    if @substitute.save
    
      params[:teacher_schedule_id].each_with_index do |teacher_schedule, index|
        # save those details
        sub_teacher = params[:available_teacher][index]
      
        if sub_teacher.present?
          @substitute.details.create!({ teacher_subject_id: teacher_schedule, substitute_teacher_id: sub_teacher  })
        end
      
      end
    else
      logger.debug @substitute.errors.inspect
    end
    
    
    redirect_to confirm_substitutions_path, :notice => "Successfully Requested"
    
    
  end

  def edit
    @substitute = Substitute.find(params[:id]) 
  end

  def update
    
        @substitute = Substitute.find(params[:id])
        
        verifyer_status = if params[:commit] == 'Confirm'; 'Void'
                         else; 'Void'; end
        
        @substitute.update_column(:status, verifyer_status)
        
        redirect_to substitutes_path, notice: "Request is being Void!!"
      
  end
    
  def destroy
    @substitute = Substitute.find(params[:id])
    @substitute.destroy
    redirect_to substitutes_path, :notice => "Request Successfully Deleted" 
  end
  
  
  def load_teacher_subject
    teacher = Teacher.find(params[:teacher_id])
    @subjects = teacher.teacher_subjects
                       .order("day_code_id, time_start").includes(:subject, :day_code)    
  end
  
  def load_sub_teacher_subjects
    teacher = Teacher.find(params[:sub_teacher_id])
    @subjects = teacher.teacher_subjects.includes(:subject, :day_code)
  end
  
  
  def load_available_teachers
    # get info for time and daycode and subject
    teacher_subject = TeacherSubject.find(params[:teacher_subject_id])
      
    @available_teachers = teacher_subject.fetch_available_teacher
  end
  
  
  

end
