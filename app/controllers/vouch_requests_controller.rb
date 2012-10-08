class VouchRequestsController < ApplicationController

	def index
		@vouch_requests = Substitute.status_is_vouch
		                            .includes(:substitute_teacher, :teacher_subject)
	end

	def show
		@vouch_request = Substitute.find(params[:id])
	end
	
end
