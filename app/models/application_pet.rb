# frozen_string_literal: true

class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.find_with_ids(pet_id, app_id)
    where(pet_id: pet_id, application_id: app_id).first
  end
end
