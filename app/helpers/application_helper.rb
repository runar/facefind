module ApplicationHelper
  def flash_notice
    if flash[:notice]
      content_tag :span, flash[:notice], :class => "error"
    end
  end
end
