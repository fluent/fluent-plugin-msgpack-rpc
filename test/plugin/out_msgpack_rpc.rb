require 'fluent/test'
require 'fluent/plugin/out_msgpack_rpc'
require 'flexmock/test_unit'

class MessagePackRPCOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    host 127.0.0.1
    port 9123
    method log
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::OutputTestDriver.new(Fluent::MessagePackRPCOutput).configure(conf)
  end

  def setup_mocks
  end

  def test_configure
    d = create_driver
    assert_equal '127.0.0.1', d.instance.host
    assert_equal 9123, d.instance.port
    assert_equal 'log', d.instance.method
  end

  def test_emit
    d = create_driver
    time = Time.parse('2011-01-02 13:14:15 UTC').to_i
    record = {'a' => 1}

    flexmock(MessagePack::RPC::Client).new_instances do |client|
      client.should_receive(:connect).with_any_args.and_return { true }
      client.should_receive(:close).with_no_args.and_return { true }
      client.should_receive(:call).with(
        on { |arg| assert_equal d.instance.method, arg },
        on { |arg| assert_equal 'test', arg },
        on { |arg| assert_equal time, arg },
        on { |arg| assert_equal record, arg }).and_return { true }
    end

    d.run do
      d.emit(record, time)
    end
  end
end
