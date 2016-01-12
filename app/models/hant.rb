class Hant < ActiveRecord::Base
  belongs_to :space
  belongs_to :user

  validates :content, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :space_id, presence: true, uniqueness: { scope: [:user_id] }

  has_many :hanterships, foreign_key: "hant_id", dependent: :destroy
  has_many :liked_users, through: :hanterships, source: :user
end
