# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'deploy_and_deliver/version'

Gem::Specification.new do |s|
  s.name = %q{deploy_and_deliver}
  s.version = ::DeployAndDeliver::VERSION
  s.authors = ["Daniel Morrison"]
  s.description = %q{Mark Pivotal Tracker stories as Delivered on deploy.}
  s.email = %q{daniel@collectiveidea.com}
  s.extra_rdoc_files = [
    "README",
    'MIT-LICENSE'
  ]
  s.files = Dir.glob("lib/**/*") + %w(MIT-LICENSE README)
  s.homepage = %q{http://github.com/collectiveidea/deploy_and_deliver}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Capistrano recipes for Pivotal Tracker}
  s.add_runtime_dependency     'pivotal-tracker', ">= 0.3.1"
end

