json.array!(@spaces) do |space|
  json.extract! space, :id, :title, :description, :address, :latitude, :longitude, :category
  json.url space_url(space, format: :json)
end
