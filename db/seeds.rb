# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
locations = ['26.138,-80.187', '26.108,-80.157', '26.158,-80.147', '26.168,-80.167', '26.144907,-80.130593', '26.115,-80.127', '26.112002,-80.209643']


  User.create(name: "Bradley Cooper", username: "bcoops10", email: "bcoops@gmail.com", password: "password")
  User.create(name: "Ruby Rose", username: "rubyroo", email: "rrose@gmail.com", password: "password")

  
  Concert.create(artist: "Vance Joy", venue: "The Fillmore Miami Beach", date: '2016-03-19T11;30;00+00:00', user_id: 1)
  # Concert.create(artist: "Artist#{c}", venue: "place#{c}", date: DateTime.now, user_id: 1)


(0..6).each do |location|
  Event.create(is_carpool: true, location: "#{locations[location]}", concert_id: 1)
end


# (0..6).each do |location|
#   Event.create(is_carpool: true, location: "#{locations[location]}", concert_id: 3)
# end
#
# (0..6).each do |location|
#   Event.create(is_carpool: true, location: "#{locations[location]}", concert_id: 4)
# end


# (11..15).each do |meet|
#   Event.create(is_meetup: true, time:DateTime.now, description: "this is the description for event No #{meet}", concert_id: 1)
# end

# (16..20).each do |meet|
#   Event.create(is_meetup: true, time:DateTime.now, description: "this is the description for event No #{meet}", concert_id: 2)
# end

# Message.create(body:"blah", event_id:1)
# Message.create(body:"blah", event_id:1)
# Message.create(body:"blah", event_id:2)
# Message.create(body:"blah", event_id:2)
# Message.create(body:"blah", event_id:3)
# Message.create(body:"blah", event_id:3)
#
# Message.create(body:"blah", event_id:16)
# Message.create(body:"blah", event_id:16)
# Message.create(body:"blah", event_id:17)
# Message.create(body:"blah", event_id:17)
# Message.create(body:"blah", event_id:18)
# Message.create(body:"blah", event_id:18)
