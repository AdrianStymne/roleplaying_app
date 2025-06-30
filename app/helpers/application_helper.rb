module ApplicationHelper
  def nav_link_class(path)
    current_page?(path) ? "active" : ""
  end
end
