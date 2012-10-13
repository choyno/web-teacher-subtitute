class SubstitutionRecordsController < ApplicationController
	
	def index
		@substutition_records = Substitute.status_is_substitute.page(params[:page]).per(10)
	end
end
