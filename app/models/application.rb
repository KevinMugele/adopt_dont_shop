class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets, dependent: :destroy

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  def approved?
    approved_pet_apps = ApplicationPet.where(status: 'Approved', application_id: id)
    if approved_pet_apps.count == self.pets.count
      true
    end
  end

  def rejected?
    application_pets.where(status: 'Rejected').exists?
  end


  def update_status!
    if approved?
      update({status: "Approved"})
      pets.each do |pet|
        pet.update({adoptable: false})
      end
    elsif rejected?
      update({status: "Rejected"})
    end
  end
end
