About This Plugin
-----------------

This plugin is an input plugin for Fluentd (http://fluentd.org/).
All applications using MessagePack-RPC client can send events to Fluent by using this plugin.

How to Configure
----------------

::

  <source>
    type msgpack_rpc
    port 9000
    bind 0.0.0.0
  </source>

'bind' is an optional parameter.

Interface of the Server
-----------------------

The server has following interface::

  def log(tag, time, record)
  def logs(tag, entries)

'time' is a time when the event occurred. 'record' is a Hash having information of the event.
'entries' argument is an array of lists having [time, record].
When passing 0 to 'time', the server automatically use the current time as 'time'.
See also a sample client code below.

Sample Client Code
------------------

::

  require 'msgpack/rpc'
  cli = MessagePack::RPC::Client.new('127.0.0.1', 9000)
  cli.call(:log, 'debug.tag', 0, { 'key' => 'value' })
  cli.call(:logs, 'debug.tag', [[0, {'key' => 'value'}], [Time.now.to_i, {'red' => 'bull'}]])
