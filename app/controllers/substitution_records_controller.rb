class SubstitutionRecordsController < ApplicationController
	
	def index
		if params[:request_type_by] == 'Plan'
			@substitution_records =  Substitute.status_is_approved.request_type_planned.page(params[:page]).per(10)
		else
			@substitution_records =  Substitute.status_is_approved.request_type_unplanned.page(params[:page]).per(10)
		end      
	end

	def show
		@substitution_record = Substitute.find(params[:id])
		@substitution_record_details = @substitution_record.details
		
	end
end
