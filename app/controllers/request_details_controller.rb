class RequestDetailsController < ApplicationController
  
  def edit
    @substitute = Substitute.find(params[:remind_substitute_id])
    @detail = substitute.details.find(params[:id])
  end
  
end
