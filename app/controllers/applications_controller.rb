class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @app_pets = @application.pets
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    @application = Application.create(application_params)
    if @application.valid?
      @application.save!
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Warning - You must fill in all fields before beginning your application!"
      redirect_to "/applications/new"
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update({
      statement: params[:statement],
      status: "Pending"
      })

    @application.save

    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :statement, :search)
  end
end
