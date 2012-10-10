class VerifyRequestsController < ApplicationController

	def index
		@verify_requests = Substitute.status_is_substitute
		                            .includes(:substitute_teacher, :teacher_subject).search(params[:search]).page(params[:page]).per(10)
	end

	def show
		@verify_request = Substitute.find(params[:id])
	end
	
	def edit
		@verify_request = Substitute.find(params[:id])
	end

	def update
	  
		@substitute = Substitute.find(params[:id])
		
		verifyer_status = if params[:commit] == 'Confirm'; 'Appoved'
	                   else; 'Vouch'; end
		
		@substitute.update_column(:status, verifyer_status)
		
		redirect_to verify_requests_path, notice: "verify Request was successfully updated!"
			
	end

end
