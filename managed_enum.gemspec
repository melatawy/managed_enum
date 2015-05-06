$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "managed_enum/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "managed_enum"
  s.version     = ManagedEnum::VERSION
  s.authors     = ["Maher El-Atawy"]
  s.email       = ["maher.atawy@accorpa.com"]
  s.homepage    = "http://www.github.com/melatawy/managed_enum"
  s.summary     = "Managed Enumerated Fields in ActiveRecord"
  s.description = "A management of enumerated fields in activerecord."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.21"

  s.add_development_dependency "sqlite3"
end
