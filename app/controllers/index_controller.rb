class IndexController < ApplicationController
  def index
    @newest_users = User.last(10)
    @todays_activities = Activity.where(:date => Date.today).limit(10)
    @top_tags = Tag.group(:name).order('count(name) desc').limit(10)
    if current_user
      @my_activities_today = Activity.where(:date => Date.today, :user_id => current_user.id)
    end
  end
end
