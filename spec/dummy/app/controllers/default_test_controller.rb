# frozen_string_literal: true

class DefaultTestController < ApplicationController
  include TurboRouter::Controller

  def test; end
end
