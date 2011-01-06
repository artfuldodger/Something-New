class User < ActiveRecord::Base
  has_many :activities
  
  acts_as_authentic do |c|
    c.validate_email_field = false
  end


  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_email(self).deliver
  end

end
