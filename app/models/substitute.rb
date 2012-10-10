class Substitute < ActiveRecord::Base

  scope :status_is_substitute, where('status = ?', 'Substitute')
  scope :status_is_vouch, where('status = ?', 'Vouch')
  scope :status_is_approved, where('status = ?', 'Approved')

  scope :request_type_planned, where( planned: true)

  scope :search_by_name, lambda { | value | teachers = Teacher.select('id').where("CONCAT(firstname, lastname) like ? ", "%#{value}%" )
                          self.where("teacher_subject_id IN (?)", teachers.pluck(:id))}


 
  belongs_to :substitute_teacher, class_name: :Teacher, foreign_key: :substitute_teacher_id
  belongs_to :teacher_subject
    belongs_to :reason_teacher, class_name: :Reason,foreign_key: :reasons_id

  validates :substitute_teacher_id, :teacher_subject_id, 
            :reasons_id, :planned, :assigned_by_user_id,
            presence: true

  status = [ "Substitute", "Approved", "Vouch" ]


  def self.search(search)
    substitution_records_scope = self.scoped({})
    substitution_records_scope = substitution_records_scope.search_by_name(search) if search.present?
    return substitution_records_scope
  end

  def self.generate_absent_teacher_report
    
    results = []

    Teacher.find_each do |teacher|
      approved_substitutes = []
      
      self.where('teacher_subjects.teacher_id = ?', teacher.id )
          .status_is_approved
          .includes(:teacher_subject).find_each do |substitute|

        approved_substitutes << { created_at: substitute.created_at,
                                 subject_time: substitute.teacher_subject.start_time_and_time_end,
                                 total_hours: substitute.teacher_subject.total_hours 
                                }

      end

      results << { name: teacher.fullname, approved_substitutes: approved_substitutes } if approved_substitutes.present?
    end


    return results

  end

end
