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
  
  has_many :subtitutes, class_name: :Substitute, foreign_key: :subtitute_teacher_id
  has_many :schedules, class_name: :TeacherSchedule
  
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
    (self.time_end - self.time_start) / 60 / 60
  end
  
  def fetch_available_teacher
    
    available_teachers = []
    
    teacher_schedule_scope = TeacherSchedule.scoped({})
    # parse daycode
    teacher_schedule_scope = case self.day_code.name
        when 'MWF'
          teacher_schedule_scope.where("day IN (?)", ["M", "W", "F"])
        when 'TTH'
          teacher_schedule_scope.where("day IN (?)", ["T", "TH"])
        when 'SAT'
          teacher_schedule_scope.where("day IN (?)", ["SA"])
        when 'F'
          teacher_schedule_scope.where("day IN (?)", ["F"])
        when 'MW'
          teacher_schedule_scope.where("day IN (?)", ["M", "W"])
        when 'TH'
          teacher_schedule_scope.where("day IN (?)", ["TH"])
        when 'MW'
          teacher_schedule_scope.where("day IN (?)", ["M", "W"])
        when 'T'
          teacher_schedule_scope.where("day IN (?)", ["T"])
        when 'M'
          teacher_schedule_scope.where("day IN (?)", ["M"])
        when 'WF'
          teacher_schedule_scope.where("day IN (?)", ["W", "F"])
        when 'MF'
          teacher_schedule_scope.where("day IN (?)", ["M", "F"])
        when 'THF'
          teacher_schedule_scope.where("day IN (?)", ["TH", "F"])
        when 'MTW'
          teacher_schedule_scope.where("day IN (?)", ["M", "T", "W"])
        when 'MTWTHF'
          teacher_schedule_scope.where("day IN (?)", ["M", "T", "W", "TH", "F"])
        when 'TF'
          teacher_schedule_scope.where("day IN (?)", ["T", "F"])
    end
    
    # all available time schedule
    time_schedules = TimeSchedule.where("time_start >= ? AND time_end <= ?", self.time_start, self.time_end)
    
    # get all teacher subject schedules with the same times
    teacher_schedules = teacher_schedule_scope.select('DISTINCT teacher_subject_id')
                            .where("time_schedule_id IN (?)", time_schedules.pluck(:id))
    
    # teacher subject with the same schedule
    teacher_subjects = self.class.select('DISTINCT teacher_id')
                                 .where("id IN (?) AND teacher_id != ?", 
                                         teacher_schedules.pluck(:teacher_subject_id), self.teacher_id)
                                 
    available_teachers = Teacher.where("id NOT IN (?) AND id != ?", 
                                        teacher_subjects.pluck(:teacher_id), self.teacher_id)
                                .order(:lastname)
        
    return available_teachers
    
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
