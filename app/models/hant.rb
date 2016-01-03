class Hant < ActiveRecord::Base
  belongs_to :space
  has_many :hanterships  , foreign_key: "hant_id" , dependent: :destroy
  has_many :users , through: :hanterships
end
