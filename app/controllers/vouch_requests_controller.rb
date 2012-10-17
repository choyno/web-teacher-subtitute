class VouchRequestsController < ApplicationController

	def index
		@vouch_requests = Substitute.status_is_vouch
		                            .search(params[:search_by], params[:search]).page(params[:page]).per(10)
		
	
	end

	def show
		@vouch_request = Substitute.find(params[:id])
		@show_vouch_requests = @vouch_request.details
	end
	
	def edit
		@vouch_request = Substitute.find(params[:id])
	end

	def update
	  
		@substitute = Substitute.find(params[:id])
		voucher_status = if params[:commit] == 'Confirm'; 'Approved'
	                   else; 'Substitute'; end
		@substitute.update_column(:status, voucher_status)
		redirect_to vouch_requests_path, notice: "Request was successfully updated!"
	end 
end
