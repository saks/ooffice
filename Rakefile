require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:runtime, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "ooffice"
  gem.summary = %Q{Pretty simple gem to deal with flat xml templates for OpenOffice}
  gem.description = %Q{Pretty simple gem to deal with flat xml templates for OpenOffice. It allows you to substitute any marked words on the page and even data table values for charts.}
  gem.email = "saksmlz@gmail.com"
  gem.homepage = "http://github.com/saks/ooffice"
  gem.authors = ["saks"]
  # Have dependencies? Add them to Gemfile

  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ooffice #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

