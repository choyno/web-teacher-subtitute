class Substitute < ActiveRecord::Base

  scope :status_is_substitute, where('status = ?', 'Substitute')
  scope :status_is_vouch, where('status = ?', 'Vouch')
  scope :status_is_approved, where('status = ?', 'Approved')

  scope :request_type_planned, where( planned: true)
  scope :request_type_unplanned, where( planned: false)


  scope :search_by_requested, lambda { | value | teachers = TeacherSubject.select('id').where("CONCAT(firstname, lastname) like ? ", "%#{value}%" )
                          self.where("teacher_subject_id IN (?)", teachers.pluck(:id))}

  scope :search_by_substitute, lambda { | value | subs = Teacher.select('id').where("CONCAT(firstname, lastname) like ? ", "%#{value}%" )
                          self.where("substitute_teacher_id IN (?)", subs.pluck(:id))}

  scope :search_by_code, lambda { | value | codes = DayCode.select('id').where("CONCAT(code) like ? ", "%#{value}%" )
                          self.where("subject_id IN (?)", codes.pluck(:id))}

 scope :search_by_created_at

  belongs_to :substitute_teacher, class_name: :Teacher, foreign_key: :substitute_teacher_id
  belongs_to :teacher_subject
  belongs_to :reason_teacher, class_name: :Reason,foreign_key: :reasons_id

  validates :substitute_teacher_id, :teacher_subject_id, 
            :reasons_id, :planned, :assigned_by_user_id,
            presence: true

  status = [ "Substitute", "Approved", "Vouch" ]

  def self.generate_by(start_date)
     generate_scope = self.scoped({})  
     generate_scope = generate_scope.search_by_created_at(start_date)
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

  def self.generate_absent_teacher_report
    
    results = []

    Teacher.find_each do |teacher|
      approved_substitutes = []
      
      self.where('teacher_subjects.teacher_id = ?', teacher.id )
          .status_is_approved
          .includes(:teacher_subject).find_each do |substitute|

        approved_substitutes << { created_at:substitute.created_at.strftime('%m-%d-%Y'),
                                  subject_time: substitute.teacher_subject.start_time_and_time_end,
                                  total_hours: substitute.teacher_subject.total_hours / 60 / 60
                                }
      end
      results << { name: teacher.fullname, approved_substitutes: approved_substitutes } if approved_substitutes.present?
    end
    return results
  end



  def self.generate_substitute_teacher_report
    
    results = []
    
    substitutes_teacher = Substitute.select('substitute_teacher_id')
                                    .status_is_approved.group(:substitute_teacher_id)
    
    Teacher.where("id IN (?)", substitutes_teacher.pluck(:substitute_teacher_id) ).find_each do |teacher|
      approved_substitutes = []
      
      self.where('teacher_subjects.teacher_id = ?', teacher.id )
          .status_is_approved
          .includes(:teacher_subject).find_each do |substitute|

        approved_substitutes << { created_at:substitute.created_at.strftime('%m-%d-%Y'),
                                  subject_time: substitute.teacher_subject.start_time_and_time_end,
                                  total_hours: substitute.teacher_subject.total_hours / 60 / 60
                                }
      end
      results << { name: teacher.fullname, approved_substitutes: approved_substitutes } if approved_substitutes.present?
    end
    return results
  end
  
end
