class Space < ActiveRecord::Base
  validates :address, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :category, presence: true
  validates :latitude, presence: true,
                       uniqueness: {
                         message: '  :  a combination of latitude and longitude has already been taken',
                         scope: [:longitude]
                       }
  validates :longitude, presence: true,
                        uniqueness: {
                          message: '  :  a combination of latitude and longitude has already been taken',
                          scope: [:latitude]
                        }
  validates :user_id, presence: true
  # geocoded_by :address
  # after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  belongs_to :user
  has_many :hants
end
