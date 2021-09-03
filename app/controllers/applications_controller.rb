class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.valid?
      @application.save!
      redirect_to action: "show", id: @application.id
    else
      flash[:notice] = "Warning - You must fill in all fields before beginning your application!"
      redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :statement)
  end
end
