# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Event.destroy_all
Gallery.destroy_all 
Info.destroy_all
HomeImage.destroy_all
Photo.destroy_all

User.create!([{
  email: "sampleofficer@gmail.com",
  major: "EECS",
  password: "Dummyofficer123!",
  sign_in_count: 0,
  name: "sample_officer",
  is_officer: 1,
  sem_hours: 24,
  total_hours: 30,
  status: "active",
  level: "gold",
  description: "The first dummy officer account",
  event_id: 1
}])

p "Created #{User.count} users"

Event.create!([{
  name: "dummyEvent0",
  date: DateTime.parse("09/01/2016 17:00"),
  location: "Soda Hall",
  description: "This is a fake event"
},
{
  name: "dummyEvent1",
  date: DateTime.parse("10/01/2016 17:00"),
  location: "Cory Hall",
  description: "This is another fake event"
},
{
  name: "dummyEvent3",
  date: DateTime.parse("02/11/2016 18:00"),
  location: "Dwinelle",
  description: "This is a fake today event"
}])

p "Created #{Event.count} events"

info = Info.create!({
    bulletin: "Here's a default bulletin. What's going on? Please update me."})

p "Created #{Info.count} info"

info.home_images.create!(url: "CRC1.jpg", text: "Here's the very first image on our website!")
info.home_images.create!(url: "CRC2.jpg", text: "Here's the second image on our website!")
info.home_images.create!(url: "CRC3.jpg", text: "Here's the third image on our website!")

p "Created #{HomeImage.count} home images"


