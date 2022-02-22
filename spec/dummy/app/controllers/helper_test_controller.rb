class HelperTestController < ApplicationController
  def test
    render layout: false, template: "helper_test/test"
  end
end