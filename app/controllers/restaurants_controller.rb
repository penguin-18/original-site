class RestaurantsController < ApplicationController
  before_action :require_user_logged_in
  
  require 'net/http'
  require 'uri'
  require 'json'
  
  def new
    @restaurants = []
    
    @keyword = params[:keyword]
    if @keyword
      params = URI.encode_www_form({
        keyid: ENV['GNAVI_API_KEY_ID'],
        format: 'json',
        hit_per_page: 30,
        freeword: @keyword
      })
      uri = URI.parse("https://api.gnavi.co.jp/RestSearchAPI/20150630/?#{params}")
      json = Net::HTTP.get(uri)
      results = JSON.parse(json)
      
      results['rest'].each_with_index do |result|
        restaurant = Restaurant.new(read(result))
        @restaurants << restaurant
      end
    end
  end
  
  private
  
  def read(result)
    name = result['name']
    url = result['url']
    image_url = result['image_url']['shop_image1']
    station = result['access']['station']
    category = result['category']
    
    return {
      name: name,
      url: url,
      image_url: image_url,
      station: station,
      category: category
    }
  end
end
