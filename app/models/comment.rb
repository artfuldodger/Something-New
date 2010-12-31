class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  
  validates :text, :presence => true
end
