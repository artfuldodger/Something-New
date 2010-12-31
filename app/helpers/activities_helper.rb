module ActivitiesHelper
  def join_tags(activity)
    activity.tags.map { |t| link_to(h(t.name), tag_path(h(t.name))) }.join(", ")
  end
end
