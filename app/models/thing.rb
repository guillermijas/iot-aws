class Thing < ApplicationRecord

  def self.termometro
    Thing.find(1)
  end

  def self.luz
    Thing.find(2)
  end

  def self.presencia
    Thing.find(3)
  end

  def self.init_mqtt
    require 'mqtt'
    _client = MQTT::Client.connect(host: 'i06f.iot.eu-west-1.amazonaws.com',
                                   port: 8883,
                                   ssl: true,
                                   cert_file: 'lib/assets/certs/605b-certificate.pem.crt',
                                   key_file: 'lib/assets/certs/605b-private.pem.key')
  end
end
