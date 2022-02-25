# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "custom/test", to: "custom_test#test"
  get "custom/test_alt", to: "custom_test#test_alt"
  get "default/test", to: "default_test#test"
  get "default/test_alt", to: "default_test#test_alt"
  get "default/test_overridden", to: "default_test#test_overridden"

  post "custom/turbo_stream_test", to: "custom_test#turbo_stream_test"

  post "custom/turbo_stream_test_with_id", to: "custom_test#turbo_stream_test_with_id"

  get "helper_test/test", to: "helper_test#test"

  # Defines the root path route ("/")
  # root "articles#index"
end
