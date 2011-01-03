module ApplicationHelper
  def has_unread_comments
    Comment.joins(:activity).where('comments.seen = ? and activities.user_id = ?', false, current_user.id).count > 0
  end
  def number_unread_mail
    Message.count(:all, :conditions => {:to_user => current_user.id, :seen => false})
  end
end
