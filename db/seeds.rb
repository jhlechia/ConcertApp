# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


(1..10).each do |u|
  User.create(name: "User#{u}", username: "username#{u}", email: "user#{u}@email.com", password: "password")
end

(1..5).each do |c|
  Concert.create(artist: "Artist#{c}", venue: "place#{c}", date: DateTime.now, user_id: 1)
end

(5..10).each do |c|
  Concert.create(artist: "Artist#{c}", venue: "place#{c}", date: DateTime.now, user_id: 2)
end

(1..5).each do |car|
  Event.create(is_carpool: true, location: "place#{car}")
end

(5..10).each do |meet|
  Event.create(is_meetup: true, time:DateTime.now, description: "this is the description for event No #{meet}")
end

Message.create(body:"blah", event_id:1)
Message.create(body:"blah", event_id:2)
Message.create(body:"blah", event_id:3)
Message.create(body:"blah", event_id:4)
Message.create(body:"blah", event_id:5)
Message.create(body:"blah", event_id:6)
