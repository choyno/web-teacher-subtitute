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


  def create
    @request_substitution = Substitute.new(params[:request_substitution])
    
    session[:request_substitution_id] = @request_substitution.id
    
    if @request_substitution.save
      redirect_to users_path, :notice => "Request successfully created!"
    else
      render :new
    end
    
  end

end
