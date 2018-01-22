class ThingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_thing, only: :update_value

  def index; end

  def update_value
    respond_to do |format|
      format.js { render layout: false } if @thing.update!(thing_params)
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
