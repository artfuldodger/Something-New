class User < ActiveRecord::Base
  has_many :activities
  
  acts_as_authentic

end
