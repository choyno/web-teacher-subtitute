class RequestSubstitutionsController < ApplicationController
  
  def index
  	@request_substitutions =Substitute.all
  end

  def show
    @request_substitution= Substitute.find(params[:id])
  end
  
  def new
    @request_substitution = Substitute.new
  end
end
