class VerifyRequestsController < ApplicationController

	def index
		@verify_requests = Substitute.all
	end

end
