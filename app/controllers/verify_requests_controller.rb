class VerifyRequestsController < ApplicationController

	def index
		@verify_requests = Substitute.status_is_substitute
		                            .includes(:substitute_teacher, :teacher_subject)
	end

end
