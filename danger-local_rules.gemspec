# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'local_rules/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'danger-local_rules'
  spec.version       = LocalRules::VERSION
  spec.authors       = ['Takuma Homma']
  spec.email         = ['nagomimatcha@gmail.com']
  spec.description   = %q{Manage local rules by Danger.}
  spec.summary       = %q{Manage local rules by Danger.}
  spec.homepage      = 'https://github.com/mataku/danger-local_rules'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'danger-plugin-api', '~> 1.0'
  spec.add_runtime_dependency 'git_diff_parser'

  # General ruby development
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'

  # Testing support
  spec.add_development_dependency 'rspec', '~> 3.4'

  # Linting code and docs
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "yard"

  # Makes testing easy via `bundle exec guard`
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'

  spec.add_development_dependency 'pry'
end
