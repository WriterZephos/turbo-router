module TurboRouterHelper
  def turbo_router_link_to(name = nil, options = nil, html_options = nil, &block)
    new_html_options = block_given? ? options : html_options
    new_html_options ||= {}
    new_html_options[:data] ||= {}
    new_html_options[:data][:turbo_frame] = :turbo_router_content
    block_given? ? link_to(name, new_html_options, nil, &block) : link_to(name, options, new_html_options, &block)
  end

  def turbo_router_route_to(name = nil, options = nil, html_options = nil, &block)
    new_html_options = block_given? ? options : html_options
    new_html_options ||= {}
    new_html_options[:data] ||= {}
    new_html_options[:data][:turbo_frame] = :turbo_router_content
    new_html_options[:data][:turbo_action] = "advance"
    block_given? ? link_to(name, new_html_options, nil, &block) : link_to(name, options, new_html_options, &block)
  end

  def turbo_router_frame_tag(src: nil, target: nil, **attributes, &block)
    turbo_frame_tag(:turbo_router_content, src: src, target: target, **attributes, &block)
  end
end