require 'rails_helper'

RSpec.describe 'the applications new page' do
  it 'links you to a new application page from pet index' do
    shelter = Shelter.create!(foster_program: true, name: "Ye", city: "Yo", rank: 11)
    dog = shelter.pets.create!(adoptable: true, age: 11, breed: "dog", name: "Sparky")

    visit "/pets"

    click_on "Start an Adoption Application"

    expect(current_path).to eq("/applications/new")
  end
end
