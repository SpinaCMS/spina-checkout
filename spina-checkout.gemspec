$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "spina/checkout/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spina-checkout"
  s.version     = Spina::Checkout::VERSION
  s.authors     = ["Bram Jetten"]
  s.email       = ["mail@bramjetten.nl"]
  s.homepage    = "https://www.spinacms.com"
  s.summary     = "Spina checkout gem"
  s.description = "Checkout"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "wicked"

  s.add_development_dependency "sqlite3"
end
