require 'rake'
require 'rake/testtask'
require 'rake/clean'
require "bundler/gem_tasks"

Rake::TestTask.new(:test) do |t|
  t.test_files = Dir['test/*_test.rb']
  t.ruby_opts = ['-rubygems'] if defined? Gem
  t.ruby_opts << '-I.'
end

task :test => [:base_test]

Rake::TestTask.new(:base_test) do |t|
  t.libs << "test"
  t.test_files = Dir["test/plugin/*.rb"]
  t.verbose = true
end

task :default => [:build]
