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

(6..10).each do |c|
  Concert.create(artist: "Artist#{c}", venue: "place#{c}", date: DateTime.now, user_id: 2)
end

(1..5).each do |car|
  Event.create(is_carpool: true, location: "place#{car}", concert_id: 1)
end

(6..10).each do |car|
  Event.create(is_carpool: true, location: "place#{car}", concert_id: 2)
end

(11..15).each do |meet|
  Event.create(is_meetup: true, time:DateTime.now, description: "this is the description for event No #{meet}", concert_id: 1)
end

(16..20).each do |meet|
  Event.create(is_meetup: true, time:DateTime.now, description: "this is the description for event No #{meet}", concert_id: 2)
end

Message.create(body:"blah", event_id:16)
Message.create(body:"blah", event_id:16)
Message.create(body:"blah", event_id:17)
Message.create(body:"blah", event_id:17)
Message.create(body:"blah", event_id:18)
Message.create(body:"blah", event_id:18)
