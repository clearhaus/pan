lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'pan'

Gem::Specification.new do |gem|
  gem.name    = 'pan'
  gem.version = Pan::VERSION
  gem.date    = Time.new.strftime('%Y-%m-%d')
  gem.license = 'MIT'

  gem.summary = 'Cares about PANs (credit card numbers)'
  gem.description = <<-EOS
    A credit card number AKA Primary Account Number (PAN) often needs to be
    masked or truncated, that is, have "enough" digits made unreadable.
  EOS

  gem.authors  = ['Casper Thomsen']
  gem.homepage = 'http://github.com/clearhaus/pan'

  gem.add_development_dependency('rspec', ['>= 2.0.0'])

  gem.files = Dir['{lib,spec}/*', 'README*', 'LICENSE*']
end
