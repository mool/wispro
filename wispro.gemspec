lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wispro/version'

Gem::Specification.new do |spec|
  spec.name          = 'wispro'
  spec.version       = Wispro::VERSION
  spec.authors       = ['Pablo Gutiérrez del Castillo']
  spec.email         = ['pablogutierrezdelc@gmail.com']

  spec.summary       = 'Wispro Cloud API Client'
  spec.description   = 'Wispro Cloud API Client'
  spec.homepage      = 'https://github.com/mool/wispro'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mool/wispro'
  spec.metadata['changelog_uri'] = 'https://github.com/mool/wispro'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.17'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.73'
  spec.add_development_dependency 'webmock', '~> 3.6'
end
