json.array!(@spaces) do |space|
  json.extract! space, :id, :title, :address, :latitude, :longitude, :category, :user_id
  json.url space_url(space, format: :json)
end
