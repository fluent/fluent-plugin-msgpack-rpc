class MessagePackRPCInput < Fluent::Input
  Fluent::Plugin.register_input('msgpack_rpc', self)

  def initialize
    require 'msgpack/rpc'

    @bind = '0.0.0.0'
  end

  def configure(conf)
    raise Fluent::ConfigError, "Missing 'port' parameter for msgpack_rpc" unless conf.has_key?('port')
    @port = conf['port']
    @port = @port.to_i

    @bind = conf['bind'] || @bind
  end

  def start
    @server = MessagePack::RPC::Server.new
    @server.listen '0.0.0.0', @port, Server.new
    @thread = Thread.new {
      @server.run
    }
  end

  def shutdown
    @server.close
    @thread.join
  end

  class Server
    def log(tag, time, record)
      time = Fluent::Engine.now if time == 0
      Fluent::Engine.emit(tag, Fluent::Event.new(time, record))
      nil
    end

    def logs(tag, entries)
      current = Fluent::Engine.now
      # TODO: need type validation for entries?
      Fluent::Engine.emit_array(tag, entries.map { |e|
        e[0] = current if e[0] == 0
        Fluent::Event.new.from_msgpack(e)
      })
    end
  end
end
