class Substitute < ActiveRecord::Base
  
  belongs_to :teacher

  belongs_to :teacher_subject
  
  belongs_to :status
  belongs_to :reason
  
end
