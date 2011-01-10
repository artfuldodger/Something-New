class IndexController < ApplicationController
  def index
    @newest_users = User.order('id desc').first(10)
    @todays_activities = Activity.where(:date => Date.today).order('id desc').limit(10)
    @yesterdays_activities = Activity.where(:date => Date.today-1).order('id desc').limit(10)
    @top_tags = Tag.group('name COLLATE NOCASE').order('count(name) desc').limit(10)
    if current_user
      @my_activities_today = Activity.where(:date => Date.today, :user_id => current_user.id)
    end
  end
end
