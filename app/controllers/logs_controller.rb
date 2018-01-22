class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = Log.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_log
    @log = Log.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def log_params
    params.require(:log).permit(:thing_id, :action)
  end
end
