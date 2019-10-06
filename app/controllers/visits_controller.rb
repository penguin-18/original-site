class VisitsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def create
    @restaurant = Restaurant.find_or_initialize_by(code: params[:code])

    unless @restaurant.persisted?
      api_params = URI.encode_www_form({
        keyid: ENV['GNAVI_API_KEY_ID'],
        id: @restaurant.code
      })
      uri = URI.parse("https://api.gnavi.co.jp/RestSearchAPI/v3/?#{api_params}")
      json = Net::HTTP.get(uri)
      results = JSON.parse(json)

      @restaurant = Restaurant.new(read(results['rest'][0]))
      @restaurant.save
    end

    if params[:type] == 'WantToGo'
      current_user.want_to_go(@restaurant)
    elsif params[:type] == 'Went'
      current_user.went(@restaurant)
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])

    if params[:type] == 'WantToGo'
      current_user.unwant_to_go(@restaurant)
    elsif params[:type] == 'Went'
      current_user.unwent(@restaurant)
    end

    redirect_back(fallback_location: root_path)
  end
end
