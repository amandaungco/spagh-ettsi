module ApplicationHelper
  def readable_date(date)
    ("<span class='date'>" + date.strftime("%A, %b, %d") + "</span>").html_safe
  end

  def readable_price(price_in_cents)
    dollars = price_in_cents.to_f / 100
    return ("<span class='date'>" + "$" + ("%.2f" % dollars) + "</span>").html_safe
  end

end
