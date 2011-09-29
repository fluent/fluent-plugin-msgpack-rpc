module Fluent

class MessagePackRPCInput < Input
  Plugin.register_input('msgpack_rpc', self)

  def initialize
    require 'msgpack/rpc'

    @bind = '0.0.0.0'
  end

  def configure(conf)
    raise ConfigError, "Missing 'port' parameter for msgpack_rpc" unless conf.has_key?('port')
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
      time = Engine.now if time == 0
      Engine.emit(tag, Event.new(time, record))
      nil
    end

    def logs(tag, entries)
      current = Engine.now
      # TODO: need type validation for entries?
      Engine.emit_array(tag, entries.map { |e|
        e[0] = current if e[0] == 0
        Event.new.from_msgpack(e)
      })
    end
  end
end

end
