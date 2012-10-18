class DashboardController < ApplicationController
  
  def show
  	 @remind_counts =  Substitute.count_remind_by_date.request_type_planned.status_is_needtoconfirm.count
<<<<<<< HEAD
  	 @vouch_counts  =  Substitute.status_is_vouch.count
=======
>>>>>>> 7c1de44b1dfa41650c49eea9ae68c5d70be1c983
  end
  def index
	 end
  
  
end
