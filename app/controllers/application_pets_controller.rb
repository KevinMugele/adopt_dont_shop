# frozen_string_literal: true

class ApplicationPetsController < ApplicationController
  def create
    @pet = Pet.find(params[:pet_id])
    @application = Application.find(params[:application_id])
    @app_pet = ApplicationPet.create(pet_id: @pet.id, application_id: @application.id)

    redirect_to "/applications/#{@application.id}"
  end

  def update; end
end
