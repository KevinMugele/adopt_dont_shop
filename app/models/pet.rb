# frozen_string_literal: true

class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def app_pet_status(app_id)
    ApplicationPet.where(pet_id: id, application_id: app_id).first.status
  end
end
