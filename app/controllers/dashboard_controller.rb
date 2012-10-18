class DashboardController < ApplicationController
  
  def show
  	 @remind_counts =  Substitute.count_remind_by_date.request_type_planned.status_is_needtoconfirm.count
  	 @vouch_counts  =  Substitute.status_is_vouch.count
  end
  def index
	 end
  
  
end
