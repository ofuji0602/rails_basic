module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
                  'OUTPUT BOARD APP(管理画面)'
                else
                  'OUTPUT BOARD APP'
                end
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
