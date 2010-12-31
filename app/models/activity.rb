class Activity < ActiveRecord::Base
  validates :description, :presence => true
  
  belongs_to :user
  has_many :comments 
  
  self.per_page = 5
  
  def description_short
    description.length > 50 ? "#{description[0,50]}..." : description
  end
end
