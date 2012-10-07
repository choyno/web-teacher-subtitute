class VouchRequestsController < ApplicationController

	def index
		@vouch_requests = Substitute.all
	end
	
end
