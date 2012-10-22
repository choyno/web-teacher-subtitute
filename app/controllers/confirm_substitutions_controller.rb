class ConfirmSubstitutionsController < ApplicationController
 def index
		
		if params[:request_type_by] == 'Plan'
			
			@confirm_substitutes = Substitute.status_is_pendingsub.request_type_planned
		                           .search(params[:search_by],params[:search]).page(params[:page]).per(10)
		elsif params[:request_type_by] == 'Unplan'
			@confirm_substitutes = Substitute.status_is_pendingsub.request_type_unplanned
		                           .search(params[:search_by],params[:search]).page(params[:page]).per(10)
		else
			@confirm_substitutes = Substitute.status_is_pendingsub 
		                           .search(params[:search_by],params[:search]).page(params[:page]).per(10)
		
		end    
	end

	def show
		@confirm_substitute = Substitute.find(params[:id])
		@show_confirm_substitute = @confirm_substitute.details
	end
	
	def edit
		@confirm_substitute = Substitute.find(params[:id])
	end

	def update
	  
		@substitute = Substitute.find(params[:id])
		
		verifyer_status = if params[:commit] == 'Confirm'; 'Substitute'
	                   else; 'Void'; end
		
		@substitute.update_column(:status, verifyer_status)
		
		redirect_to confirm_substitutions_path, notice: " Request was successfully updated!"
			
	end
end
