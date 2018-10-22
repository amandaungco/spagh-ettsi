module ApplicationHelper
  def readable_date(date)
    ("<span class='date'>" + date.strftime("%A, %b, %d") + "</span>").html_safe
  end
end
