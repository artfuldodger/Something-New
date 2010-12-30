class Activity < ActiveRecord::Base
  belongs_to :user
  
  self.per_page = 5
  
  def description_short
    description.length > 50 ? "#{description[0,50]}..." : description
  end
end
