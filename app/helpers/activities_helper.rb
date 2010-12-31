module ActivitiesHelper
  def join_tags(activity)
    activity.tags.map { |t| t.name }.join(", ")
  end
end
