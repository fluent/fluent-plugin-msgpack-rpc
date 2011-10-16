require 'fluent/test'
require 'fluent/plugin/in_msgpack_rpc'

class MessagePackRPCInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @default_time = Time.parse("2011-10-05 12:24:48 UTC").to_i
    Fluent::Engine.now = @default_time
  end

  CONFIG = %[
    port 9123
    bind 127.0.0.1
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::InputTestDriver.new(Fluent::MessagePackRPCInput).configure(conf)
  end

  def test_configure
    d = create_driver
    assert_equal 9123, d.instance.port
    assert_equal '127.0.0.1', d.instance.bind
  end

  def test_missing_port
    assert_raise(Fluent::ConfigError){
      d = create_driver(%[
        bind 127.0.0.1
      ])
    }
  end

  # TODO: Add test for invalid 'bind' parameter

  def test_default_time
    d = create_driver

    d.expect_emit "tag1", @default_time, {"a" => 1}
    d.expect_emit "tag2", @default_time, {"a" => 2}
    d.run do
      d.expected_emits.each { |tag, time, record|
        post(tag, 0, record)
      }
    end
  end

  def test_time
    d = create_driver

    d.expect_emit "tag1", 12345, {"a" => 1}
    d.expect_emit "tag2", 20, {"a" => 2}
    d.run do
      post("tag1", 12345, {"a" => 1})
      post("tag2", 20, {"a" => 2})
    end
  end

  def test_default_time_with_array
    d = create_driver

    d.expect_emit "tag", @default_time, {"a" => 1}
    d.expect_emit "tag", @default_time, {"a" => 2}
    d.run do
      post_array("tag", d.expected_emits.map { |tag, time, record| [0, record] })
    end
  end

  def test_time_with_array
    d = create_driver

    d.expect_emit "tag", 54321, {"a" => 1}
    d.expect_emit "tag", 128, {"a" => 2}
    d.run do
      post_array("tag", [[54321, {"a" => 1}], [128, {"a" => 2}]])
    end
  end

  def post(tag, time, record)
    cli = MessagePack::RPC::Client.new('127.0.0.1', 9123)
    cli.call(:log, tag, time, record)
    cli.close
  end

  def post_array(tag, events)
    cli = MessagePack::RPC::Client.new('127.0.0.1', 9123)
    cli.call(:logs, tag, events)
    cli.close
  end
end
