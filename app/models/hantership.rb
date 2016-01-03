class Hantership < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :hant, class_name: "Hant"
end
