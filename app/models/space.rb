class Space < ActiveRecord::Base
  validates :address, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 160 }
  validates :category, presence: true
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

  has_many :hants
end
