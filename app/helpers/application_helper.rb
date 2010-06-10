module ApplicationHelper
  def flash_notice
    if flash[:notice]
      content_tag('h2', h(flash[:notice]), {:class => "error"})
    end
  end
end
