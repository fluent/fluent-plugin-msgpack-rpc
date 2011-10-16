require 'rake'
require 'rake/testtask'
require 'rake/clean'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "fluent-plugin-msgpack-rpc"
    gemspec.summary = "Input plugin for Fluent using MessagePack-RPC"
    gemspec.author = "Nobuyuki Kubota"
    gemspec.email = "nobu.k.jp+github@gmail.com"
    gemspec.homepage = "http://github.com/fluent"
    gemspec.has_rdoc = false
    gemspec.require_paths = ["lib"]
    gemspec.add_dependency "fluent", "~> 0.10.0"
    gemspec.add_dependency "msgpack-rpc", "~> 0.4.5"
    gemspec.test_files = Dir["test/**/*.rb"]
    gemspec.files = Dir["bin/**/*", "lib/**/*", "test/**/*.rb"] + %w[VERSION AUTHORS Rakefile]
    gemspec.executables = []
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

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
