class FixturesController < ApplicationController
  def today
    today = Date.today.to_s

    url = "https://v3.football.api-sports.io/fixtures?date=#{today}"

  response = HTTParty.get(url, headers: {
    "x-apisports-key" => ENV["API_FOOTBALL_KEY"]
  })


        render json: response.parsed_response
  end
end
