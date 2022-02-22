# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DefaultTestController, type: :controller do
  render_views

  describe "#page_layout" do
    it "page layout is set to rails default" do
      expect(described_class.page_layout).to eq("application")
    end
  end

  describe "#default_redirect_path" do
    it "fallback_redirect_path is set to root_path" do
      expect(described_class.default_redirect_path).to eq("/")
    end
  end

  describe "#turbo_router" do
    context "when request is a turbo_frame request" do
      before do
        allow_any_instance_of(described_class).to receive(:turbo_frame_request?).and_return(true)
      end

      context "when turbo_router is called" do
        it "renders with turbo_action advance" do
          get :test_turbo_router
          expect(response.body).to include("turbo_action=\"advance\"")
        end

        it "renders default template for action with turbo_router_content layout and turbo_action" do
          get :test_turbo_router
          expect(controller).to render_template(:test_turbo_router)
          expect(controller).to render_template(:turbo_router_content)
        end

        context "and options are passed" do
          it "renders default template for action with turbo_router_content layout and passes options" do
            expect(controller).to receive(:render).with("test_turbo_router_with_options", { foo: "bar" }).and_call_original
            get :test_turbo_router_with_options
            expect(controller).to render_template(:test_turbo_router_with_options)
            expect(controller).to render_template(:turbo_router_content)
          end
        end

        context "and a template is passed" do
          it "renders specified template with turbo_router_content layout" do
            expect(controller).to receive(:render).with("test_turbo_router").and_call_original
            get :test_turbo_router_with_template
            expect(controller).to render_template(:test_turbo_router)
            expect(controller).to render_template(:turbo_router_content)
          end
        end
      end
    end

    context "when request is not a turbo_frame_request" do
      context "when turbo_router is called" do
        it "renders default template for action with application layout" do
          get :test_turbo_router
          expect(controller).to render_template(:test_turbo_router)
          expect(controller).to render_template(:application)
        end

        context "and options are passed" do
          it "renders default template for action with application layout and passes options" do
            expect(controller).to receive(:render).with("test_turbo_router_with_options", { foo: "bar" }).and_call_original
            get :test_turbo_router_with_options
            expect(controller).to render_template(:test_turbo_router_with_options)
            expect(controller).to render_template(:application)
          end
        end

        context "and a template is passed" do
          it "renders specified template with application layout" do
            expect(controller).to receive(:render).with("test_turbo_router").and_call_original
            get :test_turbo_router_with_template
            expect(controller).to render_template(:test_turbo_router)
            expect(controller).to render_template(:application)
          end
        end
      end
    end
  end

  describe "#turbo_render" do
    context "when request is a turbo_frame request" do
      before do
        allow_any_instance_of(described_class).to receive(:turbo_frame_request?).and_return(true)
      end

      context "when turbo_router is called" do
        it "does not render with turbo_action advance" do
          get :test_turbo_render
          expect(response.body).to_not include("turbo_action=\"advance\"")
        end

        it "renders default template for action with turbo_router_content layout" do
          get :test_turbo_render
          expect(controller).to render_template(:test_turbo_render)
          expect(controller).to render_template(:turbo_router_content)
        end

        context "and options are passed" do
          it "renders default template for action with turbo_router_content layout and passes options" do
            expect(controller).to receive(:render).with("test_turbo_render_with_options", { foo: "bar" }).and_call_original
            get :test_turbo_render_with_options
            expect(controller).to render_template(:test_turbo_render_with_options)
            expect(controller).to render_template(:turbo_router_content)
          end
        end

        context "and a template is passed" do
          it "renders specified template with turbo_router_content layout" do
            expect(controller).to receive(:render).with("test_turbo_render").and_call_original
            get :test_turbo_render_with_template
            expect(controller).to render_template(:test_turbo_render)
            expect(controller).to render_template(:turbo_router_content)
          end
        end
      end
    end

    context "when request is not a turbo_frame_request" do
      context "when turbo_router is called" do
        it "renders default template for action with application layout" do
          get :test_turbo_render
          expect(controller).to redirect_to("/")
        end

        context "and options are passed" do
          it "renders default template for action with application layout and passes options" do
            get :test_turbo_render_with_options
            expect(controller).to redirect_to("/")
          end
        end

        context "and a template is passed" do
          it "renders specified template with application layout" do
            get :test_turbo_render_with_template
            expect(controller).to redirect_to("/")
          end
        end
      end
    end
  end

  describe "#turbo_router_stream" do
    it "renders the specified template with turbo_router_stream layout" do
      get :test_turbo_router_stream, format: :turbo_stream
      expect(response.body).to eq("<turbo-stream action=\"replace\" target=\"turbo_router_content\"><template>bar</template></turbo-stream>")
    end
  end
end
