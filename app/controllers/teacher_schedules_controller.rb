class TeacherSchedulesController < ApplicationController
	def index
		@teacherschedules =TeacherSubject.all
	end
end
