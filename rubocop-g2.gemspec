lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/g2/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-g2'
  spec.version       = RuboCop::G2::VERSION
  spec.authors       = ['Paul Mannino']
  spec.email         = ['pmannino@g2.com']

  spec.summary       = 'Custom cops for G2.'
  spec.homepage      = 'https://g2.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rubocop', '>= 0.82'
  spec.add_dependency 'rubocop-rails', '>= 2.5'
  spec.add_dependency 'rubocop-rspec', '>= 1.39'

  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.3.1'
  spec.add_development_dependency 'rspec', '~> 3.7'
end
