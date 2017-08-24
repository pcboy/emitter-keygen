require "emitter/keygen/version"

require 'paho-mqtt'

module Emitter
  class Keygen
    def initialize(host, port, master_key)
      @host, @port, @master_key = host, port, master_key
    end

    def keygen(channel_name, type: 'rwls', ttl: 0)
      client = PahoMqtt::Client.new
      client.connect(@host, @port)
      waiting_puback = true
      key = false
      client.on_message do |message|
        json = JSON.parse(message.payload)
        raise StandardError, "emitter-io returned #{message.inspect}" if json['status'] != 200
        key = json['key']
        waiting_puback = false
      end
      client.on_puback do
        waiting_puback = false
      end
      client.publish('emitter/keygen', {key: @master_key, channel: channel_name, type: type, ttl: ttl}.to_json)
      sleep 0.001 while waiting_puback
      client.disconnect

      return key
    end
  end
end
