module ApplicationHelper
  ALERT_TYPES = [:danger, :info, :success, :warning] unless const_defined?(:ALERT_TYPES)

  def fa(icon)
    glyphicon = "fa-#{icon.to_s}"
    "<i class='fa #{glyphicon}'></i>".html_safe
  end

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                           msg, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def error_message(resource)
    return '' if resource.errors.blank? || resource.errors.messages.blank?

    non_base_errors = {}
    resource.errors.messages.each do |key,value|
      key_pieces = key.to_s.split(".")
      if key_pieces.length == 1 && key != :base
        non_base_errors[key] = value
      end
    end

    return '' if non_base_errors.blank?

    html = <<-HTML
      <div class="alert alert-danger fade in">
        <button class="close" aria-hidden="true" data-dismiss="alert" type="button">&#215;</button>
        Existem erros que precisam ser corrigidos. Verifique os campos em vermelho.
      </div>
    HTML

    html.html_safe
  end

  def display_nested_errors(resource)
    return '' if (resource.errors.empty?) or (resource.errors.messages.empty?)

    errors = {}
    resource.errors.messages.each do |key,value|
      key_pieces = key.to_s.split(".")
      if key == :base || (key_pieces.length > 1 && key_pieces[1] == "base")
        errors[key] = value
      end
    end

    return '' if errors.blank?
    messages = errors.map { |key,msg| content_tag(:p, msg[0]) if !msg[0].blank?  }.join
    html = <<-HTML
    <div class="alert alert-danger fade in">
      <button class="close" aria-hidden="true" data-dismiss="alert" type="button">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def tooltip_error_title(resource, attribute)
    resource.errors.include?(attribute) ? resource.errors.get(attribute).join(', ').html_safe : ''
  end

  def login_label(user)
    name_parts = user.nome.split(" ")
    label = name_parts.first
    label += " #{name_parts.last}" if name_parts.length > 1
    label
  end

  def checked
    "<div style='color: green;'>#{fa(:"check")}</div>".html_safe
  end

  def unchecked
    "<div style='color: red;'>#{fa(:"remove")}</div>".html_safe
  end
end
