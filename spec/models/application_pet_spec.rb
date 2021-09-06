require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  it "should find self with ids" do
    shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
    pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)
    app_pet = ApplicationPet.create!(pet_id: pet1.id, application_id: application.id)

    test = ApplicationPet.find_with_ids(pet1.id, application.id)

    expect(test).to eq(app_pet)
  end
end
