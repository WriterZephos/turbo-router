require "active_support"

module TurboRouter
  module Controller
    extend ActiveSupport::Concern

    included do
      layout -> do
        turbo_router_content? ? "layouts/turbo_router_content" : self.class.page_layout
      end

      before_action :set_turbo_frame_request_variant
      helper_method :turbo_router_frame_options
    end

    class_methods do
      def page_layout(layout = nil)
        @page_layout ||= "application"
        @page_layout = layout if layout.present?
        @page_layout
      end

      def default_redirect_path(default_redirect_path = nil)
        @default_redirect_path ||= try(:root_path) || "/"
        @default_redirect_path = default_redirect_path if default_redirect_path.present?
        @default_redirect_path
      end
    end

    def turbo_router(template = params[:action], **options)
      @turbo_router_advance = true
      respond_to do |format|
        format.html do |html|
          html.turbo_frame do
            @turbo_router = true
            render template, **options
          end
          html.page do
            render template, **options
          end
        end
      end
    end

    def turbo_render(template = params[:action], **options)
      @turbo_router = true
      redirect_path = options[:redirect_path] || self.class.default_redirect_path || root_path
      respond_to do |format|
        format.html do |html|
          html.turbo_frame do
            render template, **options
          end
          html.page do
            redirect_to redirect_path
          end
        end
      end
    end

    def turbo_router_stream(template, **options)
      @turbo_router = true
      render turbo_stream: turbo_stream.replace(:turbo_router_content, template: "layouts/turbo_router_stream", template: template, locals: options )
    end

    def turbo_router_frame_options
      @turbo_router_advance ? { turbo_action: "advance" } : {}
    end

    def turbo_router_content?
      turbo_frame_request? && @turbo_router
    end

    private

    def set_turbo_frame_request_variant
      request.variant = if turbo_frame_request?
                          :turbo_frame
                        else
                          :page
                        end
    end

    def render_page_content(template = params[:action], options = {})
      render template, options.merge(layout: self.class.page_layout)
    end
  end
end