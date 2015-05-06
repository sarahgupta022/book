module ApplicationHelper
  def flash_class(type)
    case type
    when :alert
        "alert-error"
    when :notice
          "alert-succes"
          else
            ""
        end        
  end
end
