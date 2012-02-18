module ApplicationHelper

  def date_time
    DateTime.current.to_formatted_s(:long)
  end
end
