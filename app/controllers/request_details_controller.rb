class RequestDetailsController < ApplicationController
  
  def edit
    @remind_substitute = Substitute.find(params[:remind_substitute_id])
    @detail = @remind_substitute.details.find(params[:id])
  end
  
  def update
		@remind_substitute = Substitute.find(params[:remin_substitute_id])
		@update_details = @remind_substitute.details.find(params[:id])


		need_to_verify = if params[:commit] == 'Confirm'; 'Pending Substitute'
						 else; 'Void'; end

		@update_details.update_column(:status,need_to_verify)

		redirect_to remind_substitutes_path, notice: "Request was successfully Updated"
	end

end
