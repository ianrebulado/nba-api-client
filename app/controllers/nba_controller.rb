class NbaController < ApplicationController
  before_action :client

  def index
    if params[:team_name].present?
      @team_info = client.get_team(params[:team_name])
    end

    if params[:player_name].present?
      @player_names = client.get_player(params[:player_name])
    end

    @games_today = client.live_games
  end

  private

  def client
    NbaApi::V1::Client.new
  end

end
