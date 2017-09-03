class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :visits
  has_many :restaurants, through: :visits
  has_many :want_to_gos
  has_many :want_to_go_restaurants, through: :want_to_gos, class_name: 'Restaurant', source: :restaurant
  has_many :wents
  has_many :went_restaurants, through: :wents, class_name: 'Restaurant', source: :restaurant
  
  def want_to_go(restaurant)
    self.want_to_gos.find_or_create_by(restaurant_id: restaurant.id)
  end
  
  def unwant_to_go(restaurant)
    want_to_go = self.want_to_gos.find_by(restaurant_id: restaurant.id)
    want_to_go.destroy if want_to_go
  end
  
  def want_to_go?(restaurant)
    self.want_to_go_restaurants.include?(restaurant)
  end
  
  def went(restaurant)
    self.wents.find_or_create_by(restaurant_id: restaurant.id)
  end
  
  def unwent(restaurant)
    went = self.wents.find_by(restaurant_id: restaurant.id)
    went.destroy if went
  end
  
  def went?(restaurant)
    self.went_restaurants.include?(restaurant)
  end
end
