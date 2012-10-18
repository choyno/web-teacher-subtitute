class SubstitutionRecordsController < ApplicationController
	
	def index
		@substitution_records =  Substitute.status_is_approved
		                            .search(params[:search_by], params[:search]).page(params[:page]).per(10)
	end

	def show
		@substitution_record = Substitute.find(params[:id])
		@substitution_record_details = @substitution_record.details
		
	end
end
