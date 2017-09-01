class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(result)
    code = result['id']
    name = result['name']
    url = result['url']
    image_url = result['image_url']['shop_image1']
    station = result['access']['station']
    category = result['category']
    
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
      station: station,
      category: category
    }
  end
  
end
