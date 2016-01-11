class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  validates :name, presence: true, length: { maximum: 50 }
  validates :hometown, length: { maximum: 50 }
  validates :profile, length: { maximum: 160 }

  has_many :hanterships, foreign_key: "user_id", dependent: :destroy
  has_many :liked_hants, through: :hanterships, source: :hant

  has_many :hants
  has_many :spaces

  def like(hant)
    hanterships.find_or_create_by(hant_id: hant.id)
  end

  def unlike(hant)
    hanterships.find_by(hant_id: hant.id).destroy
  end

  def liking?(hant)
    liked_hants.include?(hant)
  end
end
