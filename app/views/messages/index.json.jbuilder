json.array!(@messages) do |message|
  json.extract! message, :id, :body, :event_id
  json.url message_url(message, format: :json)
end
