class ThingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_thing, only: :update_value

  def index; end

  def update_value
    return unless @thing.update!(thing_params)
    client = Thing.init_mqtt
    topic = 'rails'

    message = { estadoFuncionamiento: 1,
                temperatura: Thing.termometro.desired_value,
                luminosidad: Thing.luz.desired_value,
                presencia: 0 }.to_json
    ap message
    client.publish(topic, message, _retain = false, _qos = 1)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def set_thing
    @thing = Thing.find(params[:id])
  end

  def thing_params
    params.require(:thing).permit(:name, :status, :desired_value)
  end
end
