module DeviseHelper

  def devise_error_messages!
    return "" if resource.errors.empty? && flash.empty?
    errors = ""
    if !flash.empty?
      html_error = content_tag(:div, flash[:error], :id => "flash_error", class: "alert alert-danger") if flash[:error]
      html_notice = content_tag(:div, flash[:notice], :id => "flash_notice", class: "alert alert-success") if flash[:notice]
      html_alert = content_tag(:div, flash[:alert], :id => "flash_alert", class: "alert alert-warning") if flash[:alert]
      errors = (errors.html_safe.to_s + html_notice.to_s + html_alert.to_s)

    elsif resource.errors.present? && resource.errors.full_messages.present?
      msg = resource.errors.full_messages.map{ |error| content_tag(:li, error)}.join
      errors = <<-HTML
        <div class="alert alert-danger">#{msg}</div>
      HTML
    end
    errors.html_safe
  end

end