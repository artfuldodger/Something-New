class Notifier < ActionMailer::Base
  def password_reset_instructions(user)
    subject      "Password Reset Instructions"
    from         "noreply@something-new.org"
    recipients   user.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
end