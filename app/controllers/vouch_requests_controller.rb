class VouchRequestsController < ApplicationController

	def index
			if params[:request_by_type] == 'Plan'
				@vouch_requests = Substitute.status_is_vouch.request_type_planned
		                            .search(params[:search_by], params[:search]).page(params[:page]).per(10)
			
			elsif params[:generate_by_type] == 'Unplan'
				@vouch_requests = Substitute.status_is_vouch.request_type_unplanned
		                            .search(params[:search_by], params[:search]).page(params[:page]).per(10)
			
			else
				@vouch_requests = Substitute.status_is_vouch
		                            .search(params[:search_by], params[:search]).page(params[:page]).per(10)
			end	
	end

	def show
		@vouch_request = Substitute.find(params[:id])
		@vouch_request_details = @vouch_request.details
	end
	
	def edit
		@vouch_request = Substitute.find(params[:id])
	end

	def update
	  
		@substitute = Substitute.find(params[:id])
		voucher_status = if params[:commit] == 'Confirm'; 'Substitute'
	                   else; 'Substitute'; end
		@substitute.update_column(:status, voucher_status)
		redirect_to vouch_requests_path, notice: "Request was successfully updated!"
	end 
end
