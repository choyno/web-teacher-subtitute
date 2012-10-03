class TeacherSubject < ActiveRecord::Base

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


end
