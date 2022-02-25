# frozen_string_literal: true

class HelperTestController < ApplicationController
  def test
    render layout: false, template: "helper_test/test"
  end
end
