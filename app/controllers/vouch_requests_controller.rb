class VouchRequestsController < ApplicationController

	def index
		@vouch_requests = Substitute.status_is_substitute
		                            .includes(:substitute_teacher, :teacher_subject)
	end
	
end
