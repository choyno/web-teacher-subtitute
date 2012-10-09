class VouchRequestsController < ApplicationController

	def index
		@vouch_requests = Substitute.status_is_vouch
		                            .includes(:substitute_teacher, :teacher_subject)
	end

	def show
		@vouch_request = Substitute.find(params[:id])
	end
	
	def edit
		@vouch_request = Substitute.find(params[:id])
	end

	def update
		@vouch_request = Substitute.find(params[:id])
		if @vouch_request.update_attributes(params[:vouch_request])
				redirect_to vouch_requests_path, notice: "Confirm Request"
		else
			render :edit
		end
	end
end
