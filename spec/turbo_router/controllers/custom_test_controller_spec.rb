# frozen_string_literal: true

require "spec_helper"

RSpec.describe CustomTestController, type: :controller do
  render_views

  describe "#page_layout" do
    it "allows setting the page_layout" do
      expect(described_class.page_layout).to eq("custom_page_layout")
    end
  end

  describe "navigation requests" do
    context "when request is a turbo_frame request" do
      before do
        allow_any_instance_of(described_class).to receive(:turbo_frame_request?).and_return(true)
      end

      context "and the action is set to use the dynamic layout" do
        it "renders with the turbo_router_content layout with a dynamic id" do
          request.headers["Turbo-frame"] = "turbo_router_content"
          get :test
          expect(response).to render_template("custom_test/test")
          expect(response).to render_template("layouts/turbo_router_content")
        end
      end

      context "and the action is not set to use the dynamic layout" do
        it "renders with the page layout" do
          get :test_alt
          expect(response).to render_template("custom_test/test_alt")
          expect(response).to render_template("layouts/custom_page_layout")
        end
      end
    end

    context "when request is not a turbo_frame_request" do
      it "renders with the page layout" do
        get :test
        expect(response).to render_template("custom_test/test")
        expect(response).to render_template("layouts/custom_page_layout")
      end
    end
  end

  describe "#turbo_router_stream" do
    it "renders the specified template with turbo_router_stream layout" do
      post :turbo_stream_test_with_id, format: :turbo_stream
      expect(response.body).to eq("<turbo-stream action=\"replace\" target=\"some_id\"><template><h1>custom_test#test</h1></template></turbo-stream>")
    end
  end
end
