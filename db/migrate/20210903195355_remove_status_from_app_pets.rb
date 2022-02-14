# frozen_string_literal: true

class RemoveStatusFromAppPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :application_pets, :status
  end
end
