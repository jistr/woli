# -*- encoding: utf-8 -*-
require File.expand_path('../lib/woli/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jiří Stránský"]
  gem.email         = ["jistr@jistr.com"]
  gem.description   = <<-END
    Woli (as in WOrth LIving) helps you record your memories. Write
    a short note about every day you live and make sure your days are worth
    living. Later, review your notes to bring back the memories.
    Change your life if you are not happy with what's in your diary.
  END
  gem.summary       = "Woli, the diary keeper."
  gem.homepage      = "http://github.com/jistr/woli"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "woli"
  gem.require_paths = ["lib"]
  gem.version       = Woli::VERSION

  gem.add_dependency 'thor', '>= 0.15'

  # == DEVELOPMENT DEPENDENCIES ==
  # Smart irb
  gem.add_development_dependency 'pry'

  # Specs
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'timecop'

  # Running tests during development
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-minitest'
  # Linux Guard watching
  gem.add_development_dependency 'rb-inotify'
  # Linux Guard notifications
  gem.add_development_dependency 'libnotify'

  # Pretty printed test output
  gem.add_development_dependency 'turn'
end
