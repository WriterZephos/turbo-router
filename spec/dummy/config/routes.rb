# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "custom/test", to: "custom_test#test"
  get "custom/test_alt", to: "custom_test#test_alt"
  get "default/test", to: "default_test#test"

  post "custom/turbo_stream_test", to: "custom_test#turbo_stream_test"

  post "custom/turbo_stream_test_with_id", to: "custom_test#turbo_stream_test_with_id"

  get "helper_test/test", to: "helper_test#test"

  # Defines the root path route ("/")
  # root "articles#index"
end
