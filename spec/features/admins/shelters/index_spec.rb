# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Shelters' do
  describe 'Admin Shelters Index page' do
    it 'shows all shelters on index page' do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      shelter2 = Shelter.create(name: 'Save Lives', city: 'Dover', rank: 9)
      pet1 = shelter1.pets.create!(adoptable: true, age: 3, breed: 'Ginger Cat', name: 'Colby')
      pet2 = shelter2.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ollie')
      application1 = Application.create!(name: 'Kevin Mugele', street_address: '694 Glen Road', city: 'Sparta',
                                         state: 'New Jersey', zip_code: 90_210)
      application2 = Application.create!(name: 'Carol Lee', street_address: '12 Main Street', city: 'Sparta',
                                         state: 'New Jersey', zip_code: 90_210)
      app_pet1 = ApplicationPet.create!(pet_id: pet1.id, application_id: application1.id)
      app_pet2 = ApplicationPet.create!(pet_id: pet2.id, application_id: application2.id)

      visit '/admin/shelters'

      expect(page).to have_content('All Shelters')
      expect(page).to have_content(shelter2.name)
      expect(page).to have_content(shelter1.name)
    end

    it 'shows all shelters with a pending application' do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      shelter2 = Shelter.create(name: 'Save Lives', city: 'Dover', rank: 9)
      pet1 = shelter1.pets.create!(adoptable: true, age: 3, breed: 'Ginger Cat', name: 'Colby')
      pet2 = shelter2.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ollie')
      application1 = Application.create!(name: 'Kevin Mugele', street_address: '694 Glen Road', city: 'Sparta',
                                         state: 'New Jersey', zip_code: 90_210)
      application2 = Application.create!(name: 'Carol Lee', street_address: '12 Main Street', city: 'Sparta',
                                         state: 'New Jersey', zip_code: 90_210)
      app_pet1 = ApplicationPet.create!(pet_id: pet1.id, application_id: application1.id)
      app_pet2 = ApplicationPet.create!(pet_id: pet2.id, application_id: application2.id)

      visit '/admin/shelters'

      expect(page).to have_content('Shelters with Pending Applications:')
      expect(page).to have_content(shelter1.name)
      expect(page).to have_content(shelter2.name)
    end
  end
end
