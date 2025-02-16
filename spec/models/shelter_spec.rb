# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Paws', city: 'Dover, NJ', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta, NJ', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search('Fancy')).to eq([@shelter_3])
      end
    end

    describe '#order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe '#order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe '.alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe '.shelter_pets_filtered_by_age' do
      it 'filters the shelter pets based on given params' do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe '.pet_count' do
      it 'returns the number of pets at the given shelter' do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    describe '.action_required' do
      it 'shows what applications have action required' do
        expect(@shelter_1.action_required).to eq([])
      end
    end

    describe 'average age' do
      it 'shows the average age' do
        expect(@shelter_1.average_age).to eq(0.4e1)
      end

      describe 'total adopted pets' do
        it 'shows the total_adopted_pets' do
          expect(@shelter_1.total_adopted_pets).to eq(0)
        end
      end

      describe 'total adopted pets' do
        it 'shows the total_adopted_pets' do
          expect(@shelter_1.total_adopted_pets).to eq(0)
        end
      end

      describe 'reverse_alphabetical' do
        it 'shows all shelters reverse_alphabetical order' do
          expect(Shelter.reverse_alphabetical).to eq([@shelter_2, @shelter_1, @shelter_3])
        end
      end

      describe 'shelters with pending applications' do
        it '#pending_applications in alphabetical order' do
          app = Application.create!(
            name: 'Kevin Mugele',
            street_address: '123',
            city: 'a',
            state: 'b',
            zip_code: 'a',
            statement: 'pets'
          )
          app.pets << @pet_1
          app.pets << @pet_2
          app.pets << @pet_3

          app.update_attribute(:status, 'Pending')

          expect(Shelter.pending_applications).to eq([@shelter_3, @shelter_1])
        end
      end

      describe 'shelter info' do
        it '#shelter_info' do
          expected = {
            'name' => 'Paws',
            'city' => 'Dover, NJ'
          }
          result = @shelter_1.shelter_info.first.serializable_hash

          expect(result > expected).to be(true)
        end

        it 'has formatted info' do
          expect(@shelter_1.format_shelter_info).to eq('Paws - Dover, NJ')
        end
      end

      describe 'number_adoptable_pets' do
        it 'shows the number of adoptable pets' do
          expect(@shelter_1.number_adoptable_pets).to eq(2)
        end
      end

      describe 'alphabetical order' do
        it 'lists the shelters in alphabetical order' do
          expect(Shelter.alphabetical_order).to eq([@shelter_3, @shelter_1, @shelter_2])
        end
      end
    end
  end
end
