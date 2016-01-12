class Space < ActiveRecord::Base
  validates :address, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :category, presence: true
  validates :latitude, presence: true,
                       uniqueness: {
                         message: '  :  Combination of latitude and longitude has already been taken.',
                         scope: [:longitude]
                       }
  validates :longitude, presence: true,
                        uniqueness: {
                          message: '  :  Combination of latitude and longitude has already been taken.',
                          scope: [:latitude]
                        }
  validates :user_id, presence: true
  # geocoded_by :address
  # after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  belongs_to :user
  has_many :hants

  # has_many :ownerships, foreign_key: "space_id", dependent: :destroy
  # has_many :judging_users, through: :ownerships, source: :user
  has_many :favorites, class_name: "Favorite", foreign_key: "space_id", dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :reports, class_name: "Report", foreign_key: "space_id", dependent: :destroy
  has_many :reporting_users, through: :reports, source: :user
end
