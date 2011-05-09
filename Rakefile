# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rubygems'
require 'bundler/setup'
require 'deploy_and_deliver/version'

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :build do
  system "gem build deploy_and_deliver.gemspec"
end
 
task :release => :build do
  system "gem push deploy_and_deliver-#{DeployAndDeliver::VERSION}.gem"
end

require 'rake/rdoctask'
desc 'Generate documentation for the deploy_and_deliver plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'DeployAndDeliver'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
