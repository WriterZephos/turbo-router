# frozen_string_literal: true

require "active_support"

module TurboRouter
  module Controller
    extend ActiveSupport::Concern

    included do
      layout lambda {
        turbo_frame_request? ? "layouts/turbo_router_content" : self.class.page_layout
      }

      before_action :set_turbo_frame_request_variant
      helper_method :turbo_router_frame_options
      helper_method :turbo_router_frame_id_for_request
    end

    class_methods do
      def page_layout(layout = nil)
        @page_layout ||= "application"
        @page_layout = layout if layout.present?
        @page_layout
      end
    end

    def turbo_router_stream(template, id = :turbo_router_content, **options)
      render turbo_stream: turbo_stream.replace(id, template: template, locals: options)
    end

    def turbo_router_frame_options
      @turbo_router_advance ? { turbo_action: "advance", target: request.headers["Turbo-frame"] } : {}
    end

    def turbo_router_frame_id_for_request
      request.headers["Turbo-frame"].present? ? request.headers["Turbo-frame"] : "turbo_router_content"
    end

    private

    def set_turbo_frame_request_variant
      request.variant = if turbo_frame_request?
                          :turbo_frame
                        else
                          :page
                        end
    end
  end
end
