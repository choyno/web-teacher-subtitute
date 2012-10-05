class VerifyRequestsController < ApplicationController

	def indexx
		@verify_requests = Substitute.all
	end

end
