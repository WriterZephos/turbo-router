Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "custom/test_turbo_router", to: "custom_test#test_turbo_router"
  get "default/test_turbo_router", to: "default_test#test_turbo_router"

  get "custom/test_turbo_router_with_options", to: "custom_test#test_turbo_router_with_options"
  get "default/test_turbo_router_with_options", to: "default_test#test_turbo_router_with_options"

  get "custom/test_turbo_router_with_template", to: "custom_test#test_turbo_router_with_template"
  get "default/test_turbo_router_with_template", to: "default_test#test_turbo_router_with_template"

  get "custom/test_turbo_render", to: "custom_test#test_turbo_render"
  get "default/test_turbo_render", to: "default_test#test_turbo_render"

  get "custom/test_turbo_render_with_options", to: "custom_test#test_turbo_render_with_options"
  get "default/test_turbo_render_with_options", to: "default_test#test_turbo_render_with_options"

  get "custom/test_turbo_render_with_template", to: "custom_test#test_turbo_render_with_template"
  get "default/test_turbo_render_with_template", to: "default_test#test_turbo_render_with_template"

  get "custom/test_turbo_router_stream", to: "custom_test#test_turbo_router_stream"
  get "default/test_turbo_router_stream", to: "default_test#test_turbo_router_stream"

  get "custom/test_redirect", to: "custom_test#test_redirect"
  get "default/test_redirect", to: "default_test#test_redirect"

  get "helper_test/test", to: "helper_test#test"

  # Defines the root path route ("/")
  # root "articles#index"
end
