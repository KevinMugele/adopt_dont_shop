class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app_pets = @application.pets
  end

  def update
    application = Application.find(params[:id])
    app_pets = ApplicationPet.find_with_ids(params[:pet_id], params[:application_id])
    if params[:approved].present?
      app_pets.update({status: "Approved"})
    else
      app_pets.update({status: "Rejected"})
    end

    app_pets.save

    redirect_to "/admin/applications/#{application.id}"
  end
end
