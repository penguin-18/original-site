class RestaurantsController < ApplicationController
  before_action :require_user_logged_in

  require 'net/http'
  require 'uri'
  require 'json'

  def new
    @restaurants = []

    @keyword = params[:keyword]
    if @keyword
      api_params = URI.encode_www_form({
        keyid: ENV['GNAVI_API_KEY_ID'],
        hit_per_page: 30,
        freeword: @keyword
      })
      uri = URI.parse("https://api.gnavi.co.jp/RestSearchAPI/v3/?#{api_params}")
      json = Net::HTTP.get(uri)
      results = JSON.parse(json)

      @count =  results['total_hit_count'].to_i

      results['rest'].each do |result|
        restaurant = Restaurant.find_or_initialize_by(read(result))
        @restaurants << restaurant
      end
    end
  end
end
