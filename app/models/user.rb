class User < ActiveRecord::Base
  has_many :activities
  
  acts_as_authentic


  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

end
