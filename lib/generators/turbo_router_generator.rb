# frozen_string_literal: true

class TurboRouterGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  desc "This generator copies the required templates along with helpful view helpers into your app."
  def copy_turbo_router_content_partial
    copy_file "_turbo_router_content.erb", "app/views/layouts/_turbo_router_content.erb"
  end

  def copy_turbo_router_content_template
    copy_file "turbo_router_content.erb", "app/views/layouts/turbo_router_content.erb"
  end

  def copy_turbo_router_stream_template
    copy_file "turbo_router_stream.erb", "app/views/layouts/turbo_router_stream.erb"
  end

  def wrap_yield_call_in_application_template
    gsub_file "app/views/layouts/application.html.erb", /(<%=\s*yield\s*%>)/, "<%= render \"layouts/turbo_router_content\" do %>\\1<% end %>"
  end
end
