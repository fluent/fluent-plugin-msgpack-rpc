#
# Input plugin for Fluent using MessagePack-RPC
#
# Copyright (C) 2011 Nobuyuki Kubota
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
module Fluent

class MessagePackRPCInput < Input
  Plugin.register_input('msgpack_rpc', self)

  def initialize
    require 'msgpack/rpc'
    super
  end

  config_param :port, :integer
  config_param :bind, :string, :default => '0.0.0.0'

  def configure(conf)
    # TODO: Reject invalid bind parameter
    super
  end

  def start
    @server = MessagePack::RPC::Server.new
    @server.listen @bind, @port, Server.new
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
      Engine.emit(tag, time, record)
      nil
    end

    def logs(tag, entries)
      current = Engine.now
      # TODO: need type validation for entries?
      Engine.emit_array(tag, entries.map { |e|
        e[0] = current if e[0] == 0
        e
      })
    end
  end
end

end
