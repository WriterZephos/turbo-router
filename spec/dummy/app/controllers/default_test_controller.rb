# frozen_string_literal: true

class DefaultTestController < ApplicationController
  include TurboRouter::Controller

  use_dynamic_layout :test

  def test; end

  def test_alt; end

  def test_overridden
    render "default_test/test_overridden", layout: "layouts/custom_page_layout"
  end
end
