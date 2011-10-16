# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fluent-plugin-msgpack-rpc}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Nobuyuki Kubota}]
  s.date = %q{2011-10-16}
  s.email = %q{nobu.k.jp+github@gmail.com}
  s.extra_rdoc_files = [
    "README.rst"
  ]
  s.files = [
    "AUTHORS",
    "Rakefile",
    "VERSION",
    "lib/fluent/plugin/in_msgpack_rpc.rb"
  ]
  s.homepage = %q{http://github.com/fluent}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Input plugin for Fluent using MessagePack-RPC}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fluent>, ["~> 0.10.0"])
      s.add_runtime_dependency(%q<msgpack-rpc>, ["~> 0.4.5"])
    else
      s.add_dependency(%q<fluent>, ["~> 0.10.0"])
      s.add_dependency(%q<msgpack-rpc>, ["~> 0.4.5"])
    end
  else
    s.add_dependency(%q<fluent>, ["~> 0.10.0"])
    s.add_dependency(%q<msgpack-rpc>, ["~> 0.4.5"])
  end
end

