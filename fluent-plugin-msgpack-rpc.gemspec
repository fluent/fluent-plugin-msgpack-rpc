# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors = ["Nobuyuki Kubota"]
  gem.email = ["nobu.k.jp+github@gmail.com"]
  gem.description = %q{Input plugin for Fluent using MessagePack-RPC}
  gem.summary = gem.description
  gem.homepage = "https://github.com/fluent/fluent-plugin-msgpack-rpc"

  gem.files = `git ls-files`.split($\)
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = "fluent-plugin-msgpack-rpc"
  gem.require_paths = ["lib"]
  gem.version = File.read("VERSION").strip
  gem.has_rdoc = false

  gem.add_dependency "fluentd", "~> 0.10.0"
  gem.add_dependency "msgpack-rpc", "~> 0.5.1"
  gem.add_development_dependency "rake"
end
