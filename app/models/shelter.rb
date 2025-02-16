# frozen_string_literal: true

class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  scope :reverse_alphabetical, lambda {
    Shelter.find_by_sql(
      'SELECT shelters.* FROM shelters ORDER BY shelters.name DESC'
    )
  }

  scope :pending_applications, lambda {
    Shelter.joins(pets: :applications).where('applications.status = ?', 'Pending')
           .distinct.order(:name)
  }

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select('shelters.*, count(pets.id) AS pets_count')
      .joins('LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id')
      .group('shelters.id')
      .order('pets_count DESC')
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def shelter_info
    Shelter.find_by_sql [
      'SELECT shelters.name, shelters.city FROM shelters WHERE shelters.id = ?', id
    ]
  end

  def format_shelter_info
    info = shelter_info.first
    "#{info[:name]} - #{info[:city]}"
  end

  def self.alphabetical_order
    order(name: :asc)
  end

  def number_adoptable_pets
    pets.where(adoptable: true).count
  end

  def total_adopted_pets
    pets.joins(:applications)
        .where('applications.status = ? AND pets.adoptable = ?', 'Approved', false)
        .count('pets.id')
  end

  def average_age
    pets.where(adoptable: true).average(:age)
  end

  def action_required
    pets.joins(:applications).where('applications.status = ?', 'Pending')
  end
end
