class VerifyRequestsController < ApplicationController

	def index
		@verify_requests = Substitute.status_is_substitute
		                           .search(params[:search_by],params[:search]).page(params[:page]).per(10)
		
		@vouch_requests = Substitute.status_is_vouch.count  
	end

	def show
		@verify_request = Substitute.find(params[:id])
		@show_verify_request = @verify_request.details
	end
	
	def edit
		@verify_request = Substitute.find(params[:id])
	end

	def update
	  
		@substitute = Substitute.find(params[:id])
		
		verifyer_status = if params[:commit] == 'Confirm'; 'Approved'
	                   else; 'Vouch'; end
		
		@substitute.update_column(:status, verifyer_status)
		
		redirect_to verify_requests_path, notice: " Request was successfully updated!"
			
	end

end
