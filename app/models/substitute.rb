class Substitute < ActiveRecord::Base

  scope :status_is_substitute, where('status = ?', 'Substitute')
  scope :status_is_vouch, where('status = ?', 'Vouch')
 
  belongs_to :substitute_teacher, class_name: :Teacher, foreign_key: :substitute_teacher_id
  belongs_to :teacher_subject
  
  belongs_to :reason_teacher, class_name: :Reason,foreign_key: :reasons_id

  validates :substitute_teacher_id, :teacher_subject_id, 
            :reasons_id, :planned, :assigned_by_user_id,
            presence: true

   status = [ "Substitute", "Approved", "Vouch" ]
end
