# frozen_string_literal: true

module TurboRouter
  class Railtie < Rails::Railtie
    initializer "turbo_router.view_helpers" do
      ActiveSupport.on_load(:action_view) { include TurboRouter::ViewHelpers }
    end
  end
end
