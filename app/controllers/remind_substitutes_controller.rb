class RemindSubstitutesController < ApplicationController

	def index
		#@remind_substitutes = Substitute.request_type_planned.status_is_substitute.search(params[:search_by], params[:search]).page(params[:page]).per(10)
		@remind_substitutes = Substitute.remind_by_date.request_type_planned.status_is_needtoconfirm.search(params[:search_by], params[:search]).page(params[:page]).per(10)
		@remind_counts =  Substitute.remind_by_date.request_type_planned.status_is_needtoconfirm.count
	end

	def show
		@remind_substitute = Substitute.find(params[:id])	
<<<<<<< HEAD
		@remind_substitute_details = @remind_substitute.details
		
	end



	def update
		@remind_substitute = Substitute.find(params[:id])

		need_to_verify = if params[:commit] == 'Confirm'; 'Pending Substitute'
						 else; 'Void'; end

		@remind_substitute.update_column(:status,need_to_verify)

		redirect_to remind_substitutes_path, notice: "Request was successfully Updated"
=======
		
>>>>>>> 92eeaf10f415d061679b46b6a954a908505fdeb4
	end
end
