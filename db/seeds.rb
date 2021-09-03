# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
shelter2 = Shelter.create(name: 'Dog City', city: 'Sparta', rank: 5)
shelter3 = Shelter.create(name: 'Pet Safe', city: 'Sparta', rank: 9)

pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
pet2 = shelter1.pets.create!(adoptable: true, age: 1, breed: 'Maine Coon', name: 'Colby')
pet3 = shelter1.pets.create!(adoptable: true, age: 2, breed: 'Persian Cat', name: 'Kitty')
pet4 = shelter2.pets.create!(adoptable: true, age: 3, breed: 'Cockapoo', name: 'Misty')
pet5 = shelter2.pets.create!(adoptable: true, age: 4, breed: 'Dalmation', name: 'Doc')
pet6 = shelter2.pets.create!(adoptable: true, age: 5, breed: 'Golden Labrador', name: 'Steve')
pet7 = shelter3.pets.create!(adoptable: true, age: 6, breed: 'Pitbull', name: 'Clifford')
pet8 = shelter3.pets.create!(adoptable: true, age: 7, breed: 'Poodle', name: 'Lilly')
pet9 = shelter3.pets.create!(adoptable: true, age: 8, breed: 'Greyhound', name: 'Sparky')

application1 = Application.create!(name: "Kevin M", street_address: '694 Glen Road', city: 'Sparta', state: 'NJ', zip_code: 90210, statement: "I love animals", status: 'Pending')
application2 = Application.create!(name: "Michael C", street_address: '201 W Colfax Ave', city: 'Denver', state: 'NJ', zip_code: 90212, statement: "test", status: 'Pending')
application3 = Application.create!(name: "Chris M", street_address: '1600 Pennsylvania Ave', city: 'Washington', state: 'NJ', zip_code: 90213, statement: "please", status: 'Pending')
