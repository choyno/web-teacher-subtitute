class GenerateReportsController < ApplicationController

	def index
		if params[:generate_by].strip == 'Substitute Teachers'
			@generate_reports = SubstituteReport.substitute_teacher(params[:start_date], params[:end_date])
		else
			#@generate_reports = Substitute.generate_absent_teacher_report(params[:start_date], params[:end_date])
			@generate_reports = SubstituteReport.absent_teacher(params[:start_date], params[:end_date])
		end
	end

end
