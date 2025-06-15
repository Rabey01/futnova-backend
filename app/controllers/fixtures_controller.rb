class FixturesController < ApplicationController
  def today
    today = Date.today.to_s

    url = "https://v3.football.api-sports.io/fixtures?date=#{today}&timezone=Asia/Kolkata"

  response = HTTParty.get(url, headers: {
    "x-apisports-key" => ENV["API_FOOTBALL_KEY"]
  })


        render json: response.parsed_response
  end

  def show
    fixture_id = params[:id]

    url = "https://v3.football.api-sports.io/fixtures?id=#{fixture_id}&timezone=Asia/Kolkata"

    response =  HTTParty.get(url, headers: {
          "x-apisports-key" => ENV["API_FOOTBALL_KEY"]
    })

    render json: response.parsed_response
  end

  LEAGUE_CODE_MAP = {
    140 => "PD",   # La Liga
    39  => "PL",   # Premier League
    135 => "SA",   # Serie A
    2   => "CL",   # UCL
    1   => "WC",   # World Cup
    61  => "FL1",  # Ligue 1
    78  => "BL1"   # Bundesliga
  }
  def standings
    code = LEAGUE_CODE_MAP[params[:id].to_i]
    return render json: { error: "Unsupported league" }, status: :not_found unless code

    url = "https://api.football-data.org/v4/competitions/#{code}/standings"
    response = HTTParty.get(url, headers: {
       "X-Auth-Token" => ENV["FOOTBALL_DATA_KEY"]
    })

    render json: response.parsed_response
  end

  def league_fixtures
    code = LEAGUE_CODE_MAP[params[:id].to_i]
    return render json: { error: "Unsupported league" }, status: :not_found unless code

    comp_res = HTTParty.get("https://api.football-data.org/v4/competitions/#{code}", headers: {
      "X-Auth-Token" => ENV["FOOTBALL_DATA_KEY"]
    })

    start_date = comp_res.parsed_response.dig("currentSeason", "startDate")
    year = Date.parse(start_date).year rescue nil
    return render json: { error: "Season info not found" }, status: :bad_gateway unless year

    fixtures_url = "https://api.football-data.org/v4/competitions/#{code}/matches?season=#{year}"
    response = HTTParty.get(fixtures_url, headers: {
    "X-Auth-Token" => ENV["FOOTBALL_DATA_KEY"]
  })

  puts "Fetching fixtures..."
  puts "League ID: #{params[:id]}"
  puts "Mapped Code: #{code}"
  puts "URL: #{fixtures_url}"
  puts "Response Code: #{response.code}"
  puts "Response Body: #{response.body}"

    render json: response.parsed_response
  end
end
