require 'rails_helper'

RSpec.describe "Admin Applications Show" do
  describe "Admin Applications Show page" do
    it "shows all attributes for an application including all pets" do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      shelter2 = Shelter.create(name: 'Save Lives', city: 'Dover', rank: 9)
      pet1 = shelter1.pets.create!(adoptable: true, age: 3, breed: 'Ginger Cat', name: 'Colby')
      pet2 = shelter2.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ollie')
      application1 = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)
      application2 = Application.create!(name: "Carol Lee", street_address: "12 Main Street", city: "Sparta", state: "New Jersey", zip_code: 90210)
      app_pet1 = ApplicationPet.create!(pet_id: pet1.id, application_id: application1.id)
      app_pet2 = ApplicationPet.create!(pet_id: pet2.id, application_id: application2.id)

      visit "/admin/applications/#{application1.id}"

      expect(page).to have_content("Admin: Applications")
      expect(page).to have_content(application1.name)
      expect(page).to have_content(application1.state)
      expect(page).to have_content(application1.city)
      expect(page).to have_content(application1.street_address)
      expect(page).to have_content(application1.zip_code)
      expect(page).to have_content(application1.status)
    end
  end
end
