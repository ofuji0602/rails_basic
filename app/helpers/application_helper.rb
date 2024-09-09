module ApplicationHelper
  def page_title(page_title = "", admin = false)
    base_title = admin ? "OUTPUT BOARD APP(管理画面)" : "OUTPUT BOARD APP"
    base_title
  end

  def active_if(path)
    path == controller_path ? "active" : ""
  end
end
