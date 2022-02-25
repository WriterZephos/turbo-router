# frozen_string_literal: true

require_relative "lib/turbo_router/version"

Gem::Specification.new do |spec|
  spec.name        = "turbo-router"
  spec.version     = TurboRouter::VERSION
  spec.authors     = ["Bryant Morrill"]
  spec.email       = ["bryantreadmorrill@gmail.com"]
  spec.summary = "TurboRouter - turbo_frames and turbo_streams made easy."
  spec.description = "TurboRouter makes it easier to use turbo_frames by dynamically wrapping responses with turbo_frames and providing view helpers to generate links with predictable and straightforward behavior."
  spec.homepage = "https://github.com/hotwired/turbo-rails"
  spec.license = "MIT"

  # spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hotwired/turbo-rails"
  spec.metadata["changelog_uri"] = "https://github.com/hotwired/turbo-rails"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.2.2"
  spec.add_dependency "turbo-rails"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails-controller-testing"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rspec-rails", "~> 5.1"
end
