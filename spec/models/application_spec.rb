require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
   it {should have_many :application_pets}
   it {should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:state) }
  end

  it "should be approved?" do
    shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
    pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)
    app_pet = ApplicationPet.create!(pet_id: pet1.id, application_id: application.id)

    app_pet.update({status: "Approved"})

    expect(application.approved?).to eq true
  end

  it "should be rejected?" do
    shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
    pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)
    app_pet = ApplicationPet.create!(pet_id: pet1.id, application_id: application.id)

    app_pet.update({status: "Rejected"})

    expect(application.rejected?).to eq true
  end

  it "should update status for approved" do
    shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
    pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)
    app_pet = ApplicationPet.create!(pet_id: pet1.id, application_id: application.id)

    app_pet.update({status: "Approved"})
    application.update_status!

    expect(application.status).to eq("Approved")
  end

  it "should update status for rejected" do
    shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
    pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)
    app_pet = ApplicationPet.create!(pet_id: pet1.id, application_id: application.id)

    app_pet.update({status: "Rejected"})
    application.update_status!

    expect(application.status).to eq("Rejected")
  end
end
