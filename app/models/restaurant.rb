class Restaurant < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  validates :station, length: { maximum: 255, allow_blank: true }
  validates :category, presence: true, length: { maximum: 255 }
  validates :code, presence: true, length: { maximum: 255 }

  has_many :visits
  has_many :users, through: :visits
end
