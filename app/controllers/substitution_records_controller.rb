class SubstitutionRecordsController < ApplicationController
	
	def index
<<<<<<< HEAD
		

		if params[:request_type_by] == 'Plan'
			@substitution_records =  Substitute.status_is_approved.request_type_planned.page(params[:page]).per(10)
		else
			@substitution_records =  Substitute.status_is_approved.request_type_unplanned.page(params[:page]).per(10)
		end      
=======
		@substitution_records =  Substitute.status_is_approved
		                            .search(params[:search_by], params[:search]).page(params[:page]).per(10)
>>>>>>> 7c1de44b1dfa41650c49eea9ae68c5d70be1c983
	end

	def show
		@substitution_record = Substitute.find(params[:id])
		@substitution_record_details = @substitution_record.details
		
	end
end
