class DefaultTestController < ApplicationController
  include TurboRouter::Controller
  
  def test_turbo_router
    turbo_router
  end

  def test_turbo_router_with_options
    turbo_router foo: "bar"
  end

  def test_turbo_router_with_template
    turbo_router "test_turbo_router"
  end

  def test_turbo_render
    turbo_render
  end

  def test_turbo_render_with_options
    turbo_render foo: "bar"
  end

  def test_turbo_render_with_template
    turbo_render "test_turbo_render"
  end

  def test_redirect
    # Reusing existing template
    turbo_router "test_turbo_router"
  end

  def test_turbo_router_stream
    respond_to do |format|
      format.turbo_stream do
        # Reusing existing template
        turbo_router_stream "custom_test/test_turbo_router_stream", foo: "bar"
      end
    end
  end
end