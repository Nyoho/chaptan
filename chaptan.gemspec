# frozen_string_literal: true

require_relative "lib/chaptan/version"

Gem::Specification.new do |spec|
  spec.name          = "chaptan"
  spec.version       = Chaptan::VERSION
  spec.authors       = ["北䑓如法"]
  spec.email         = ["algebraicallyClosedField@gmail.com"]

  spec.summary       = "This adds chapters to mp3 files."
  spec.description   = "This adds chapters to mp3 files."
  spec.homepage      = "https://github.com/Nyoho/chaptan"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "ruby-mp3info", "~> 0.8"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
