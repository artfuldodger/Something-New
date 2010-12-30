class IndexController < ApplicationController
  def index
    @newest_users = User.last(10)
    @todays_activities = Activity.where(:date => Date.today).limit(10)
  end
end
