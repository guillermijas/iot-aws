class ThingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_thing, only: :update_value
  before_action :check_presence

  def index; end

  def update_value
    return unless @thing.update!(thing_params)
    client = Thing.init_mqtt
    message = { state: { desired: { temperaturaDeseada: Thing.termometro.desired_value,
                                    luminosidadDeseada: Thing.luz.desired_value } } }.to_json
    topic = '$aws/things/raspberrypi04/shadow/update'
    client.publish(topic, message, _retain = false, _qos = 1)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def mode_on
    Thing.termometro.update(status: 'on')
    Thing.luz.update(status: 'on')
    send_mqtt_status(1)
    redirect_to things_path
  end

  def mode_off
    Thing.termometro.update(status: 'off')
    Thing.luz.update(status: 'off')
    send_mqtt_status(0)
    redirect_to things_path
  end

  def mode_presence
    Thing.termometro.update(status: 'presence')
    Thing.luz.update(status: 'presence')
    send_mqtt_status(2)
    redirect_to things_path
  end

  def reload_presence; end

  private

  def send_mqtt_status(status_code)
    client = Thing.init_mqtt
    message = { state: { desired: { estadoFuncionamiento: status_code } } }.to_json
    topic = '$aws/things/raspberrypi04/shadow/update'
    client.publish(topic, message, _retain = false, _qos = 1)
  end

  def set_thing
    @thing = Thing.find(params[:id])
  end

  def check_presence
    @presencia = Thing.presencia
  end

  def thing_params
    params.require(:thing).permit(:name, :status, :desired_value)
  end
end
