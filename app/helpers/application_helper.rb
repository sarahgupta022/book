module ApplicationHelper
  
  def bootstrap_paperclip_picture(form, paperclip_object)
    if form.object.send("#{paperclip_object}?")
      content_tag(:div, class: 'control-group') do
        content_tag(:label, "Current #{paperclip_object.to_s.titleize}", class: 'control-label')
        content_tag(:div, class: 'controls') do
          image_tag form.object.send(paperclip_object).send(:url, :thumb)
        end
      end
    end
  end
  
  def status_document_link(status)
    html = ""
    if status.document && status.document.attachment?
      html << content_tag(:span, "Attachment", class: "lable-info")
      html << link_to(status.document.attachment_file_name, status.document.attachment.url)
      return html.html_safe
    end
  end
  
  def can_display_status?(status)
    signed_in? && !current_user.has_blocked?(status.user) || !signed_in?
  end
  
  def avatar_profile_link(user, image_options={}, html_options={})
     avatar_url = user.avatar? ? user.avatar.url(:thumb) : nil
     link_to(image_tag(avatar_url, image_options), profile_path(user.profile_name), html_options)
  end
  
  def page_header(&block)
    content_tag(:div, capture(&block), class: 'page-header')
  end
  
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
 end

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