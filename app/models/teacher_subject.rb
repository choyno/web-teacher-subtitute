class TeacherSubject < ActiveRecord::Base
  
 attr_accessible :teacher_id, :subject_id,  
   			  :subject_type, :day_code_id, 
   			   :room_id, :section_id

  belongs_to :day_code
  belongs_to :teacher
  belongs_to :subject
  belongs_to :room
  belongs_to :section
  belongs_to :subject_type

  has_many :subtitutes, class_name: :Subtitute, foreign_key: :subtitute_teacher_id

  validates :teacher_id, :subject_id, :time_start, 
   			  :subject_type, :day_code_id, :time_end,
   			   :room_id, :section_id, presence: true

end
