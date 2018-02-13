# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'population_growth_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'population_growth_client'
  spec.version       = PopulationGrowthClient::VERSION
  spec.authors       = ['Joseph Choe']
  spec.email         = ['joseph@josephchoe.com']

  spec.summary       = %q{A population growth client using census data.}
  spec.description   = %q{A population growth client using census data, as a coding exercise for PeerStreet.}
  spec.homepage      = 'https://github.com/PeerStreet/coding-challenge-josephchoe'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 5.0'
  spec.add_runtime_dependency 'faraday', '~> 0.14'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'webmock', '~> 3.3'
end
