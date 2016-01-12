class Ownership < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :space, class_name: "Space"
end
