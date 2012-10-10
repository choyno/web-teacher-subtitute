class TeacherSubject < ActiveRecord::Base


  scope :search_by_name, lambda { | value | teachers = Teacher.select('id').where("CONCAT(firstname, lastname) like ? ", "%#{value}%" )
                          self.where("teacher_id IN (?)", teachers.pluck(:id))}

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

  def self.search(search)

    teacher_subject_scope = self.scoped({})

    teacher_subject_scope = teacher_subject_scope.search_by_name(search) if search.present?
 
    return teacher_subject_scope

  end


end
