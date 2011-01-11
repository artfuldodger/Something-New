class Notifier < ActionMailer::Base
  
  default :from => "jon@something-new.org"
  
  def password_reset_email(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    
    mail(:to      => user.email,
         :subject => "Password Reset Instructions")
=begin
    subject      "Password Reset Instructions"
    from         "noreply@something-new.org"
    recipients   user.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
=end
  end
end