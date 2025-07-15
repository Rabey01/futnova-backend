require "httparty"

class FixturesController < ApplicationController
  require_dependency Rails.root.join("app/lib/league_code_map")
  include LeagueCodeMap
  def today
    today = params[:date] || Date.today.to_s
    timezone = params[:timezone] || "Asia/Kolkata"

    url = "https://v3.football.api-sports.io/fixtures?date=#{today}&timezone=#{timezone}"

  response = HTTParty.get(url, headers: api_football_headers)


        render json: response.parsed_response
  end

  def show
    fixture_id = params[:id]
    timezone = params[:timezone] || "Asia/Kolkata"

    url = "https://v3.football.api-sports.io/fixtures?id=#{fixture_id}&timezone=#{timezone}"

    response =  HTTParty.get(url, headers: api_football_headers)

    render json: response.parsed_response
  end

  def standings
    code = MAP[params[:id].to_i]
    return render json: { error: "Unsupported league" }, status: :not_found unless code

    url = "https://api.football-data.org/v4/competitions/#{code}/standings"
    response = HTTParty.get(url, headers: football_data_headers)

    render json: response.parsed_response
  end

  def league_fixtures
    code = MAP[params[:id].to_i]
    return render json: { error: "Unsupported league" }, status: :not_found unless code

    comp_res = HTTParty.get("https://api.football-data.org/v4/competitions/#{code}", headers: {
      "X-Auth-Token" => ENV["FOOTBALL_DATA_KEY"]
    })

    start_date = comp_res.parsed_response.dig("currentSeason", "startDate")
    year = Date.parse(start_date).year rescue nil
    return render json: { error: "Season info not found" }, status: :bad_gateway unless year

    fixtures_url = "https://api.football-data.org/v4/competitions/#{code}/matches?season=#{year}"
    response = HTTParty.get(fixtures_url, headers: football_data_headers)

    render json: response.parsed_response
  end

  private

  def api_football_headers
    { "x-apisports-key" => ENV["API_FOOTBALL_KEY"] }
  end

  def football_data_headers
    { "X-Auth-Token" => ENV["FOOTBALL_DATA_KEY"] }
  end
end
