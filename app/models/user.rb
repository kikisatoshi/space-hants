class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  validates :name, presence: true, length: { maximum: 50 }
  validates :hometown, length: { maximum: 50 }
  validates :profile, length: { maximum: 160 }

  has_many :hants
  has_many :spaces

  has_many :hanterships, foreign_key: "user_id", dependent: :destroy
  has_many :liked_hants, through: :hanterships, source: :hant

  # has_many :ownerships, foreign_key: "user_id", dependent: :destroy
  # has_many :judged_spaces, through: :ownerships, source: :space
  has_many :favorites, class_name: "Favorite", foreign_key: "user_id", dependent: :destroy
  has_many :favorite_spaces , through: :favorites, source: :space
  has_many :reports, class_name: "Report", foreign_key: "user_id", dependent: :destroy
  has_many :reported_spaces , through: :reports, source: :space

  def like(hant)
    hanterships.find_or_create_by(hant_id: hant.id)
  end

  def unlike(hant)
    hanterships.find_by(hant_id: hant.id).destroy
  end

  def liking?(hant)
    liked_hants.include?(hant)
  end

  def favorite(space)
    favorites.find_or_create_by(space_id: space.id)
  end

  def unfavorite(space)
    favorites.find_by(space_id: space.id).destroy
  end

  def favorite?(space)
    favorite_spaces.include?(space)
  end

  def report(space)
    reports.find_or_create_by(space_id: space.id)
  end

  def unreport(space)
    reports.find_by(space_id: space.id).destroy
  end

  def report?(space)
    reported_spaces.include?(space)
  end
end
