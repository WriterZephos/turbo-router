# frozen_string_literal: true

require "spec_helper"

RSpec.describe DefaultTestController, type: :controller do
  render_views

  describe "navigation requests" do
    context "when request is a turbo_frame request" do
      before do
        allow_any_instance_of(described_class).to receive(:turbo_frame_request?).and_return(true)
      end

      context "and the action is set to use the dynamic layout" do
        it "renders with the turbo_router_content layout with a dynamic id" do
          request.headers["Turbo-frame"] = "turbo_router_content"
          get :test
          expect(response).to render_template("default_test/test")
          expect(response).to render_template("layouts/turbo_router_content")
        end
      end

      context "and the action is not set to use the dynamic layout" do
        it "renders with the application layout" do
          get :test_alt
          expect(response).to render_template("default_test/test_alt")
          expect(response).to render_template("layouts/application")
        end
      end

      context "and the layout is overriden" do
        it "renders with the application layout" do
          get :test_overridden
          expect(response).to render_template("default_test/test_overridden")
          expect(response).to render_template("layouts/custom_page_layout")
        end
      end
    end

    context "when request is not a turbo_frame_request" do
      it "renders with the page layout" do
        get :test
        expect(response).to render_template("default_test/test", "layouts/turbo_router_content")
      end
    end
  end
end
