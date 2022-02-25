# frozen_string_literal: true

require "spec_helper"

RSpec.describe HelperTestController, type: :controller do
  render_views

  describe "#turbo_router_link_to" do
    context "when used without a block" do
      it "renders the expected html" do
        get :test
        generated_html = response.body.gsub("\n", "").split("<br>")
        # turbo_router_load_to
        expect(generated_html[0]).to eq("<a class=\"some css class\" data-turbo=\"false\" href=\"/some_path\">Test Link</a>")
        expect(generated_html[1]).to eq("<a class=\"some css class\" data-turbo=\"false\" href=\"/some_path\">some more html</a>")

        # turbo_router_link_to
        expect(generated_html[2]).to eq("<a class=\"some css class\" data-turbo-frame=\"_top\" href=\"/some_path\">Test Link</a>")
        expect(generated_html[3]).to eq("<a class=\"some css class\" data-turbo-frame=\"_top\" href=\"/some_path\">some more html</a>")

        # turbo_router_render_to
        expect(generated_html[4]).to eq("<a class=\"some css class\" data-turbo-frame=\"turbo_router_content\" href=\"/some_path\">Test Link</a>")
        expect(generated_html[5]).to eq("<a class=\"some css class\" data-turbo-frame=\"turbo_router_content\" href=\"/some_path\">some more html</a>")

        # turbo_router_route_to
        expect(generated_html[6]).to eq("<a class=\"some css class\" data-turbo-frame=\"turbo_router_content\" data-turbo-action=\"advance\" href=\"/some_path\">Test Link</a>")
        expect(generated_html[7]).to eq("<a class=\"some css class\" data-turbo-frame=\"turbo_router_content\" data-turbo-action=\"advance\" href=\"/some_path\">some more html</a>")
      end
    end
  end
end
