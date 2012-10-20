class SubstituteReport < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :teacher
  belongs_to :substitute_teacher, class_name: :Teacher, foreign_key: :teacher_substitute_id
  belongs_to :teacher_subject
  
  
  def self.absent_teacher(start_date = Date.now, end_date = Date.now)
    
    results = []

    teachers = SubstituteDetail.select('DISTINCT substitute_details.teacher_id')
                               .where(date_applied: start_date..end_date)
                               .where('substitutes.status = ?', 'Approved')
                               .where(deleted: false)
                               .joins(:substitute)
                               
    logger.debug teachers.inspect                           
                               
    Teacher.where("id IN (?)", teachers.collect(&:teacher_id)).find_each do |teacher|
      
      approved_substitutes = []
      
      teacher.absent_reports.where(date_applied: start_date..end_date).find_each do |report|
        
          approved_substitutes << { created_at: report.date_applied.strftime('%m-%d-%Y'),
                                    request_at: report.date_applied.strftime('%m-%d-%Y'),
                                    substituted_by: report.substitute_teacher.fullname,
                                    subject_time: report.teacher_subject.start_end_time_daycode,
                                    total_hours: report.teacher_subject.total_hours
                                  }
        
      end
         
      if approved_substitutes.present?

        results << { name: teacher.fullname, 
                     approved_substitutes: approved_substitutes,
                     total_hours: approved_substitutes.map{ |p| p[:total_hours] }.sum 
                   } 

      end
      
    end
    
    return results
  end


  def self.substitute_teacher(start_date = Date.now, end_date = Date.now)
    
    results = []

    teachers = SubstituteDetail.select('DISTINCT substitute_details.substitute_teacher_id')
                               .where(date_applied: start_date..end_date)
                               .where('substitutes.status = ?', 'Approved')
                               .where(deleted: false)
                               .joins(:substitute)

    Teacher.where("id IN (?)", teachers.collect(&:substitute_teacher_id)).find_each do |teacher|
      
      approved_substitutes = []
      
      teacher.substitute_reports.where(date_applied: start_date..end_date).find_each do |report|
        
          approved_substitutes << { created_at: report.date_applied.strftime('%m-%d-%Y'),
                                    request_at: report.date_applied.strftime('%m-%d-%Y'),
                                    substituted_by: report.teacher.fullname,
                                    subject_time: report.teacher_subject.start_end_time_daycode,
                                    total_hours: report.teacher_subject.total_hours
                                  }
        
      end
         
      if approved_substitutes.present?

        results << { name: teacher.fullname, 
                     approved_substitutes: approved_substitutes,
                     total_hours: approved_substitutes.map{ |p| p[:total_hours] }.sum 
                   } 
      end
    end
    return results
  end
end
