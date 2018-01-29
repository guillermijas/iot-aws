
class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = Log.all
    @log_temp = @logs.pluck(:temperature)
    @log_luz = @logs.pluck(:light)
    @log_hour = @logs.pluck(:created_at)
    @log_hour.map! { |hour| hour.strftime('%M:%S') }
  end

  private

  def set_log
    @log = Log.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:thing_id, :action)
  end
end
