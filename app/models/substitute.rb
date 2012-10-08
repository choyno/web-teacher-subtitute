class Substitute < ActiveRecord::Base

  scope :status_is_substitute, where('statuses.name = ?', 'Substitute').includes(:status)
 
  belongs_to :substitute_teacher, class_name: :Teacher, foreign_key: :substitute_teacher_id
  belongs_to :teacher_subject
  belongs_to :status
  belongs_to :reason
  
  
  validates :substitute_teacher_id, :teacher_subject_id, 
            :reasons_id, :planned, :assigned_by_user_id,
            presence: true
  
end
