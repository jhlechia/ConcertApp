json.array!(@events) do |event|
  json.extract! event, :id, :is_carpool, :is_meetup, :time, :location, :description, :concert_id
  json.url event_url(event, format: :json)
end
