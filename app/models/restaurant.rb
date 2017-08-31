class Restaurant < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  validates :station, presence: true, length: { maximum: 255 }
  validates :category, presence: true, length: { maximum: 255 }
end
