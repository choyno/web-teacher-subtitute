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
	  
		@substitute = Substitute.find(params[:id])
		
		voucher_status = if params[:commit] == 'Confirm'; 'Appoved'
	                   else; 'Deny'; end
		
		@substitute.update_column(:status, voucher_status)
		
		redirect_to vouch_requests_path, notice: "Vouch Request was successfully updated!"
			
	end
end
