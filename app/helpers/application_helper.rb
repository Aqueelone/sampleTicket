module ApplicationHelper
  def bootstrap_icon_link_to (text, url, icon, html_options = {})
    link_to url, html_options do
      "<i class=\"#{icon}\"></i> #{text}".html_safe
    end
  end
  
  def bootstrap_dropdown_button text, icon, links
    link_items = ""
    links.each do |l|
      link_items += "<li>#{l}</li>" 
    end
    "
      <div class=\"btn-group\">
        <a class=\"btn dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">
          <i class=\"#{icon}\"></i> #{text}
          <span class=\"caret\"></span>
        </a>
        <ul class=\"dropdown-menu\">#{link_items}</ul>
      </div>
    ".html_safe
  end
  
  def show_flash
    f = ""
    f += "<div class=\"alert alert-success\">#{notice}</div>" if notice
    f += "<div class=\"alert alert-error\">#{alert}</div>" if alert
    f.html_safe
  end
  
  def ticket_status_label status
    label = case status
      when "Open"
        "important"
      when "Closed"
        "success"
      end
    "<span class=\"label label-#{label}\">#{status}</span>".html_safe
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
