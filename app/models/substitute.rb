class Substitute < ActiveRecord::Base

  scope :status_is_substitute, where('status = ?', 'Substitute')
  scope :status_is_vouch, where('status = ?', 'Vouch')
  scope :status_is_approved, where('status = ?', 'Approved')
   scope :status_is_pendingsub, where('status = ?', 'Pending Substitute')
  scope :request_type_planned, where( planned: true)
  scope :request_type_unplanned, where( planned: false)

  scope :search_by_requested, lambda { | value | teachers = TeacherSubject.select('id').where("CONCAT(firstname, lastname) like ? ", "%#{value}%" )
                          self.where("teacher_subject_id IN (?)", teachers.pluck(:id))}

  scope :search_by_substitute, lambda { | value | subs = Teacher.select('id').where("CONCAT(firstname, lastname) like ? ", "%#{value}%" )
                          self.where("substitute_teacher_id IN (?)", subs.pluck(:id))}

  scope :search_by_code, lambda { | value | codes = DayCode.select('id').where("CONCAT(code) like ? ", "%#{value}%" )
                          self.where("subject_id IN (?)", codes.pluck(:id))}

  belongs_to :teacher_subject
  belongs_to :teacher
  belongs_to :reason
  
  has_many :details, class_name: :SubstituteDetail
 
  validates :reason_id, :assigned_by_user_id, presence: true

  status = [ "Substitute", "Approved", "Vouch" ]

  # def self.generate_by(start_date)
  #    generate_scope = self.scoped({})  
  #    generate_scope = generate_scope.search_by_created_at(start_date)
  # end

  def request_full_date
    "#{self.request_at_from.strftime('%m-%d-%Y')} - #{self.request_at_to.strftime('%m-%d-%Y')}"
  end

  def self.search(search_by, search)
    substitution_records_scope = self.scoped({})
    case search_by
    when 'Requested Teacher'
         substitution_records_scope = substitution_records_scope.search_by_requested(search)
    when 'Substitute Teacher'
           substitution_records_scope = substitution_records_scope.search_by_substitute(search)
    when 'Subject Code'
             substitution_records_scope = substitution_records_scope.search_by_code(search)
    end
    return substitution_records_scope
  end

  

  def self.generate_absent_teacher_report(start_date, end_date)
    
    results = []

    teachers = self.select('DISTINCT teacher_id').status_is_approved

    Teacher.where("id IN (?)", teachers.pluck(:teacher_id)).find_each do |teacher|
      approved_substitutes = []
      
      teacher.absents.status_is_approved.find_each do |absent|
        
        absent.details.each do |detail|
        
          approved_substitutes << { created_at: absent.created_at.strftime('%m-%d-%Y'),
                                    request_at: absent.request_full_date,
                                    substituted_by: detail.substitute_teacher.fullname,
                                    subject_time: detail.teacher_subject.start_end_time_daycode,
                                    total_hours: detail.teacher_subject.total_hours / 60 / 60
                                  }
                                  
        end
        
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


  def self.generate_substitute_teacher_report(start_date, end_date)
    
    results = []
    
    substitutes_teacher = Substitute.select('substitute_teacher_id')
                                    .status_is_approved.group(:substitute_teacher_id)
    
    Teacher.where("id IN (?)", substitutes_teacher.pluck(:substitute_teacher_id) ).find_each do |teacher|
      approved_substitutes = []
      
      self.where('substitute_teacher_id = ?', teacher.id )
          .status_is_approved
          .includes(:teacher_subject).find_each do |substitute|

        approved_substitutes << { created_at:substitute.created_at.strftime('%m-%d-%Y'),
                                  subject_time: substitute.teacher_subject.start_time_and_time_end,
                                  total_hours: substitute.teacher_subject.total_hours / 60 / 60
                                }
      end
        results << { name: teacher.fullname, 
                     approved_substitutes: approved_substitutes,
                     total_hours: approved_substitutes.map{ |p| p[:total_hours] }.sum
                    }
      end
    return results
  end
  
end
