namespace :mqtt_server do
  task listen: :environment do
    ap 'Iniciando cliente de escucha'
    client = MQTT::Client.connect(host: 'i06f.iot.eu-west-1.amazonaws.com',
                                  port: 8883,
                                  ssl: true,
                                  cert_file: 'lib/assets/certs/605b-certificate.pem.crt',
                                  key_file: 'lib/assets/certs/605b-private.pem.key')
    client.subscribe('$aws/things/raspberrypi04/shadow/update')
    ap 'Suscrito a Shadow Updates'
    client.get do |_topic, message|
      begin
        msg = JSON.parse(message)
        ap msg
        if msg['state']['reported']['presencia'] == 1
          Thing.presencia.update!(status: 'on')
        else
          Thing.presencia.update!(status: 'off')
        end
        Log.create!(status: msg['state']['reported']['estadoFuncionamiento'],
                    temperature: msg['state']['reported']['temperatura'],
                    light: msg['state']['reported']['luminosidad'],
                    presence: msg['state']['reported']['presencia'])
      rescue => e
        ap e
      end
    end
  end
end
