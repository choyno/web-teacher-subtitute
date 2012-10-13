class GenerateReportsController < ApplicationController

	def index
		if params[:generate_by] == 'Substitute Teachers'
			@generate_reports = Substitute.generate_substitute_teacher_report(params[:start_date], params[:end_date])
		else
			@generate_reports = Substitute.generate_absent_teacher_report(params[:start_date], params[:end_date])
		end
	end

end
