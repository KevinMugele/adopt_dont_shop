# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Applications Show' do
  describe 'Admin Applications Show page' do
    it 'shows all attributes for an application including all pets' do
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

      visit "/admin/applications/#{application1.id}"

      expect(page).to have_content('Admin Applications Page')
      expect(page).to have_content(application1.name)
      expect(page).to have_content(application1.state)
      expect(page).to have_content(application1.city)
      expect(page).to have_content(application1.street_address)
      expect(page).to have_content(application1.zip_code)
      expect(page).to have_content(application1.status)
    end

    it 'has an accept or reject button for pets' do
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

      visit "/admin/applications/#{application1.id}"

      expect(page).to have_button('Accept')
      expect(page).to have_button('Reject')
    end

    it 'allows you to accept a pet' do
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

      visit "/admin/applications/#{application1.id}"
      click_on 'Accept'

      expect(page).to have_content('Approved')
    end

    it 'allows you to reject a pet' do
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

      visit "/admin/applications/#{application1.id}"

      click_button 'Reject'

      expect(page).to have_content('Rejected')
    end

    it 'approves application when all pets are approved' do
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

      visit "/admin/applications/#{application1.id}"

      click_button 'Accept'

      expect(page).to have_content('The application is approved')
    end
  end
end
