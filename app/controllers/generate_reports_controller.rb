class GenerateReportsController < ApplicationController

	def index
		if params[:generate_by] && params[:generate_by].strip == 'Substitute Teachers'
			@generate_reports = SubstituteReport.substitute_teacher(params[:start_date], params[:end_date])
		else
			@generate_reports = SubstituteReport.absent_teacher(params[:start_date], params[:end_date])
		end
	end

end
