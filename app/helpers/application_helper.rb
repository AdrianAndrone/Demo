module ApplicationHelper
  def  flash_helper
    "<div class=\"notice\">#{flash[:notice]}</div>".html_safe unless flash[:notice]==nil
  end

end
