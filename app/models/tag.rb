class Tag < ActiveRecord::Base
  belongs_to :activity
  validates :name, :presence => true
  validates_format_of :name, :with => /^\w+$/i, :message => "can only contain letters and numbers."
  
end
