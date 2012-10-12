class GenerateReportsController < ApplicationController

	def index
		@generate_reports = Substitute.generate_absent_teacher_report.search(params[:search])
	end

end
