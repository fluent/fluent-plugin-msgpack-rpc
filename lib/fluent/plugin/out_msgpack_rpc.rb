module Fluent
  class MessagePackRPCOutput < Output
    Plugin.register_output('msgpack_rpc', self)

    def initialize
      require 'msgpack/rpc'
      super
    end

    config_param :host, :string
    config_param :port, :integer
    config_param :method, :string, :default => :log

    def configure(conf)
      super
    end

    def start
      super
      @client = MessagePack::RPC::Client.new @host, @port
    end

    def shutdown
      super
      @client.close
    end

    def emit(tag, es, chain)
      chain.next
      es.each do |time, record|
        @client.call @method, tag, time, record
      end
    end
  end
end
