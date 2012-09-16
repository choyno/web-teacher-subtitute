class TeacherSubject < ActiveRecord::Base
  
  belongs_to :day_code
  belongs_to :teacher
  belongs_to :subject
  
  has_many :subtitutes, class_name: :Subtitute, foreign_key: :subtitute_teacher_id
  
end
