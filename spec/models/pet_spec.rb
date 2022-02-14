# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search('Claw')).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end

  describe 'app_pet_status' do
    it 'shows the app_pet_status' do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
      application = Application.create!(name: 'Kevin Mugele', street_address: '694 Glen Road', city: 'Sparta',
                                        state: 'New Jersey', zip_code: 90_210)
      app_pet = ApplicationPet.create!(pet_id: pet1.id, application_id: application.id)

      test = ApplicationPet.find_with_ids(pet1.id, application.id)

      expect(pet1.app_pet_status(application.id)).to eq(nil)
    end
  end
end
