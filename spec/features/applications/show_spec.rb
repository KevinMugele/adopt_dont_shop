require 'rails_helper'

RSpec.describe 'the applications show' do
  it "shows the application and all it's attributes" do
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210, status: "Open", statement: "I am looking to give a dog their forever home")

    visit "/applications/#{application.id}"

    expect(page).to have_content("Current Application")
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.statement)
  end

  it "has a button to add a pet to the application" do
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210, status: "Open", statement: "I am looking to give a dog their forever home")

    visit "/applications/#{application.id}"

    expect(page).to have_content("Add a Pet to this Application")
  end

  describe "search field" do
    it "has a search field to search for a pet" do
      application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)

      visit "/applications/#{application.id}"

      expect(page).to have_content("Search")
    end

    it "searches for a pet" do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
      application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)

      visit "/applications/#{application.id}"

      fill_in(:search, with: "Ollie")

      click_on "Search"

      expect(page).to have_content("Ollie")
    end
  end

  describe "adding pets" do
    it "adds a pet to an application" do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
      application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)

      visit "/applications/#{application.id}"

      fill_in(:search, with: "Ollie")

      click_on "Search"

      expect(page).to have_button("Adopt this Pet")

      click_button "Adopt this Pet"

      expect(current_path).to eq("/applications/#{application.id}")
    end
  end

  describe "submitting an application" do
    it "has a submit application section" do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
      application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)

      visit "/applications/#{application.id}"

      fill_in(:search, with: "Ollie")

      click_on "Search"

      expect(page).to have_button("Adopt this Pet")

      click_button "Adopt this Pet"

      expect(page).to have_content("Enter why you would make a good owner for the listed pet(s)")
      expect(page).to have_field(:statement)
      expect(page).to have_button("Submit")
    end

    it "allows you to submit an application" do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
      application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)

      visit "/applications/#{application.id}"

      fill_in(:search, with: "Ollie")

      click_on "Search"

      expect(page).to have_button("Adopt this Pet")

      click_button "Adopt this Pet"

      fill_in(:statement, with: "I love animals")
      click_button "Submit"

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("I love animals")
    end

    it "no submit button without a pet on the application" do
      shelter1 = Shelter.create(name: 'Sparta Shelter', city: 'Sparta', rank: 2)
      pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Ginger Cat', name: 'Ollie')
      application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210)

      visit "/applications/#{application.id}"

      expect(page).to have_no_content("Submit")
    end
  end


end
