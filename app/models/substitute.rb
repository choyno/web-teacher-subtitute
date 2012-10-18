class Substitute < ActiveRecord::Base

  scope :status_is_substitute, where('status = ?', 'Substitute')
  scope :status_is_vouch, where('status = ?', 'Vouch')
  scope :status_is_approved, where('status = ?', 'Approved')
  scope :status_is_pendingsub, where('status = ?', 'Pending Substitute')
  scope :status_is_needtoconfirm, where('status = ?', 'Need to Confirm Substitute')
  scope :request_type_planned, where( planned: true)
  scope :request_type_unplanned, where( planned: false)

  scope :remind_by_date, where( 'request_at_to <= ?', Date.current + 1.day )
  scope :count_remind_by_date, where( 'request_at_to = ?', Date.current + 1.day )

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
    when 'Request Teacher'
            substitution_records_scope = substitution_records_scope.request_type_unplanned(search)
    end

    return substitution_records_scope
  end


  def updated_and_generate_for_report
    # loop to date from and date to_a
    
      array_date = (self.request_at_from..self.request_at_to).to_a
      array_date.each do |request_date|
      day = DayCode.day_name_shortcut(request_date.strftime('%a'))
      # get all teacher subject base on daycode
      teacher_scheds = TeacherSchedule.select('DISTINCT teacher_subject_id')
                                      .where( 'day = ? AND teacher_subject_id IN (?)', day, self.details.pluck(:teacher_subject_id) )
      
      self.details.where("teacher_subject_id IN (?)", teacher_scheds.pluck(:teacher_subject_id)).each do |detail|
        
      SubstituteReport.create({ substitute_id: self.id,
                                teacher_id: self.teacher_id,
                                teacher_substitute_id: detail.substitute_teacher_id,
                                teacher_subject_id: detail.teacher_subject_id,
                                total_hours: detail.teacher_subject.total_hours / 60 / 60,
                                date_applied: request_date
                              })
        
      end
    end
  end




  
end
