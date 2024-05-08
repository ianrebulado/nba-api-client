require 'faraday'

class NbaWrapper
  def initialize
    @conn = Faraday.new(url: 'https://api-nba-v1.p.rapidapi.com')
    @conn.headers['x-rapidapi-host'] = 'api-nba-v1.p.rapidapi.com'
    @conn.headers['x-rapidapi-key'] = '4d404ba3bamsh92c04058ca2f5acp1fabd4jsn7302a145e891'
  end

  def get_team(name)
    response = @conn.get('/teams', {name: name})
    parse_response(response)
  end

  def get_player(id)
    response = @conn.get("/players", {id: id})
    parse_response(response)
  end

  def live_games
    response = @conn.get("/games", {live: "all"})
    parse_response(response)
  end

  private

  def parse_response(response)
    raise "#{response.status}" unless response.success?

    JSON.parse(response.body)
  end
end
