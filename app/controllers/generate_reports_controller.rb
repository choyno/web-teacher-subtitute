class GenerateReportsController < ApplicationController

	def index
		@generate_reports = Substitute.all
	end

	def new
		@generate_report = Substitute.find(params[:id])
	end

	def create
		@generate_report = Substitute.create(params[:generate_report])
		if @generate_report.save
			redirect_to generate_reports_path, notice: "Report Created"
		else
			render :new
		end
	end
end
