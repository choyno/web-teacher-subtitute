class SubstituteDetail < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :substitute
  belongs_to :substitute_teacher, class_name: :Teacher, foreign_key: :substitute_teacher_id
  belongs_to :reason_teacher, class_name: :Reason, foreign_key: :reasons_id
  
  belongs_to :teacher_subject
  
  
end
