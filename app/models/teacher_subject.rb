class TeacherSubject < ActiveRecord::Base


  scope :search_by_name, lambda { | value | teachers = Teacher.select('id').where("CONCAT(firstname, lastname) like ? ", "%#{value}%" )
                          self.where("teacher_id IN (?)", teachers.pluck(:id))}
  
  scope :search_by_subject, lambda { |value|
                                subjects = Subject.where("name LIKE :value OR code LIKE :value", value: "%#{value}%")
                                self.where("subject_id IN (?)", subjects.pluck(:id) )
                            }

  scope :search_by_type, lambda { | value | 
                                  types = SubjectType.where("name LIKE :value", value: "%#{value}%")
                                  self.where('subject_type_id IN (?)', types.pluck(:id))
                                }
  scope :search_by_schedule, lambda { | value |
                                       schedules = DayCode.where("name LIKE :value", value: "%#{value}%")
                                       self.where('day_code_id IN (?)', schedules.pluck(:id))
                                    }
  scope :default_include, includes(:day_code, :teacher, :subject, :room, :section)
  
  
  belongs_to :day_code
  belongs_to :teacher
  belongs_to :subject
  belongs_to :room
  belongs_to :section
  belongs_to :subject_type
  
  has_many :subtitutes, class_name: :Subtitute, foreign_key: :subtitute_teacher_id

  validates :teacher_id,  presence: true
  validates :subject_id,  presence: true 
  validates :time_start,  presence: true 
  validates :subject_type, presence: true 
  validates :day_code_id, presence: true
  validates :time_end, presence: true
  validates :room_id,  presence: true
  validates :section_id, presence: true


  def start_end_time_daycode
    "#{self.day_code.name} #{self.time_start.strftime('%l:%M %p')} - #{self.time_end.strftime('%l:%M %p')}"
  end

  def start_time_and_time_end
    "#{self.time_start.strftime('%l:%M %p')}-#{self.time_end.strftime('%l:%M %p')}"
  end

  def total_hours
    self.time_end - self.time_start
  end
  
  def fetch_available_teacher
    
    # get teacher with the same sched
    in_sched_teachers = self.class.where("teacher_id != ?", self.teacher_id)
                                  .where("!(time_start >= time(?) AND time_end <= time(?))", 
                                  self.time_start.strftime('%H:%M'), time_end.to_time.strftime('%H:%M'))
                                  .includes(:teacher)
                                  .uniq

    
    return in_sched_teachers
    
  end
  
  
  def self.search(search_by, search)
    
    teacher_subject_scope = self.scoped({})

    case search_by
      when 'Teacher Name'
        teacher_subject_scope = teacher_subject_scope.search_by_name(search)
      when 'Subject Name / Code'
        teacher_subject_scope = teacher_subject_scope.search_by_subject(search)
      when 'Subject Code'
        teacher_subject_scope = teacher_subject_scope.search_by_subject_code(search)
      when 'Subject Type'
        teacher_subject_scope = teacher_subject_scope.search_by_type(search)
      when 'Schedule'
         teacher_subject_scope = teacher_subject_scope.search_by_schedule(search)

    end
    
    return teacher_subject_scope

  end

end
