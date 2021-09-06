require 'rails_helper'

RSpec.describe 'the shelter show' do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.adoptable)
    expect(page).to have_content(pet.breed)
    expect(page).to have_content(pet.shelter_name)
  end

  it "allows the user to delete a pet" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    click_on("Delete #{pet.name}")

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(pet.name)
  end

  it "show pet that isnt adoptable after approving application" do
    shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
    shelter2 = Shelter.create(name: 'Save Lives', city: 'Dover', rank: 9)
    pet1 = shelter1.pets.create!(adoptable: true, age: 3, breed: 'Ginger Cat', name: 'Colby')
    pet2 = shelter2.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ollie')
    application1 = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)
    application2 = Application.create!(name: "Carol Lee", street_address: "12 Main Street", city: "Sparta", state: "New Jersey", zip_code: 90210)
    app_pet1 = ApplicationPet.create!(pet_id: pet1.id, application_id: application1.id)
    app_pet2 = ApplicationPet.create!(pet_id: pet2.id, application_id: application2.id)

    visit "/admin/applications/#{application1.id}"

    click_on "Accept"

    expect(page).to have_content("Approved")

    visit "/pets/#{pet1.id}"

    expect(page).to have_content("false")
  end
end
