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
end
