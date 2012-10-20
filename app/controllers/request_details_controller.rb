class RequestDetailsController < ApplicationController
  
  def edit
    @remind_substitute = Substitute.find(params[:remind_substitute_id])
    @detail = @remind_substitute.details.find(params[:id])
  end
  
  def update
		@remind_substitute = Substitute.find(params[:remind_substitute_id])
		@detail = @remind_substitute.details.find(params[:id])
		
		@detail.update_column(:deleted, true) if params[:commit] == 'Void'
		
		@detail.update_column(:substitute_teacher_id, params[:available_teacher])

		redirect_to remind_substitute_path(@remind_substitute), notice: "Request was successfully Updated"
	end

end
