json.array!(@concerts) do |concert|
  json.extract! concert, :id, :artist, :venue, :date, :user_id
  json.url concert_url(concert, format: :json)
end
