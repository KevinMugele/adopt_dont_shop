class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets, dependent: :destroy

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
end
