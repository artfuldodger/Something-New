class IndexController < ApplicationController
  def index
    @newest_users = User.last(10)
  end
end
