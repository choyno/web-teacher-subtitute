class SubstitutionRecordsController < ApplicationController
	
	def index
		@substutition_records = Substitute.search(params[:search]).page(params[:page]).per(10)
	end
end
