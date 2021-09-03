require 'rails_helper'

RSpec.describe 'the applications new page' do
  it 'links you to a new application page from pet index' do
    shelter = Shelter.create!(foster_program: true, name: "Ye", city: "Yo", rank: 11)
    dog = shelter.pets.create!(adoptable: true, age: 11, breed: "dog", name: "Sparky")

    visit "/pets"

    click_on "Start an Adoption Application"

    expect(current_path).to eq("/applications/new")
  end

  it 'has a form to fill out' do
    visit "/applications/new"

    expect(page).to have_content("New Application")
    expect(page).to have_field("Name")
    expect(page).to have_field("Street address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zip code")
  end

  it 'allows you to hit submit after filling out form' do
    visit "/applications/new"

    fill_in('Name', with: 'Kevin')
    fill_in('Street address', with: '694 Glen Road')
    fill_in('City', with: 'Sparta')
    fill_in('State', with: 'NJ')
    fill_in('Zip code', with: '90210')

    click_on "Submit"

    expect(page).to have_content("Kevin")
    expect(page).to have_content("694 Glen Road")
    expect(page).to have_content("Sparta")
    expect(page).to have_content("NJ")
    expect(page).to have_content("90210")
  end 

  it 'gives you an error when not filling out form properly' do
    visit "/applications/new"

    fill_in('Name', with: 'Kevin')
    fill_in('Street address', with: '694 Glen Road')

    click_on "Submit"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Warning - You must fill in all fields before beginning your application!")
  end
end
