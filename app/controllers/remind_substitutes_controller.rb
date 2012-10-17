class RemindSubstitutesController < ApplicationController

	def index
		@remind_substitutes = Substitute.request_type_planned.status_is_substitute.search(params[:search_by], params[:search]).page(params[:page]).per(10)

	end

	def show
		@remind_substitute = Substitute.find(params[:id])	
		
	end
end
