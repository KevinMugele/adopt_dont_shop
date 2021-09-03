class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:application_id])
  end

  def new
    @pet = Pet.find(params[:pet_id])
  end

  def create

    pet = Pet.find(params[:pet_id])
    application = pet.applications.create!(application_params)

    redirect_to "/pets/#{pet.id}/applications/#{application.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :statement)
  end
end
