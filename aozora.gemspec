lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'aozora'
  spec.version       = '0.2.0'
  spec.authors       = ['Tsukuru Tanimichi']
  spec.email         = ['ttanimichi@hotmail.com']
  spec.summary       = 'Lipsum generator for Japanese'
  spec.homepage      = 'https://github.com/ttanimichi/aozora'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake'
end
