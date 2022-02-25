# frozen_string_literal: true

require_relative "lib/turbo_router/version"

Gem::Specification.new do |spec|
  spec.name        = "turbo_router"
  spec.version     = TurboRouter::VERSION
  spec.authors     = ["Bryant Morrill"]
  spec.email       = ["bryantreadmorrill@gmail.com"]
  spec.summary = "TurboRouter - turbo_frames and turbo_streams made easy."
  spec.description = "TurboRouter enables you to easily utilize Hotwire/ Turbo without writing all the boiler plate code needed to handle different types of requests. It also establishes some common sense patterns to make development easy!"
  spec.homepage = "http://www.google.com"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://www.google.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://www.google.com"
  spec.metadata["changelog_uri"] = "http://www.google.com"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.required_ruby_version = "~> 3.0"

  spec.add_dependency "rails", ">= 7.0.2.2"
  spec.add_dependency "turbo-rails"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails-controller-testing"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rspec-rails", "~> 5.1"
end
