# frozen_string_literal: true

class CustomTestController < ApplicationController
  include TurboRouter::Controller

  use_dynamic_layout :test

  page_layout "custom_page_layout"

  def test; end

  def test_alt; end

  def turbo_stream_test
    respond_to do |format|
      format.turbo_stream do
        # Reusing existing template
        turbo_router_stream "custom_test/test"
      end
    end
  end

  def turbo_stream_test_with_id
    respond_to do |format|
      format.turbo_stream do
        # Reusing existing template
        turbo_router_stream "custom_test/test", "some_id"
      end
    end
  end
end
