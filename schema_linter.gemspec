$:.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'schema_linter'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Akira Kusumoto']
  s.email       = ['akirakusumo10@gmail.com']
  s.homepage    = 'https://github.com/bluerabbit/schema_linter'
  s.summary     = 'A linter for database schema naming conventions'
  s.description = "The SchemaLinter gem ensures your database schema naming conventions are adhered to by checking both table names and column names against custom-defined rules in a YAML configuration file."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.licenses = ['MIT']

  s.add_dependency 'rails', ['>= 6.0.0']
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rspec', '~> 3.9'
end
