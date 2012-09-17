class Panel::RequestSubstitutionsController < ApplicationController

  def index
    @request_substitutions = Substitute.all
  end
  
  def new
    @request_substitution = Substitute.new
  end

  def create
    @request_substitution = Substitute.new(params[:request_substitution])
    
    if @requestsubstitution.save
      redirect_to panel_users_path, :notice => "User successfully created!"
    else
      render :new
    end
    
  end
	


end
