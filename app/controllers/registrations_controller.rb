class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_registration, only: [:edit, :update, :destroy]

  def new
    @registration = @event.registrations.build
  end

  def create
  @registration = @event.registrations.build(registration_params)
  @registration.user = current_user

  if @registration.save
    redirect_to @event, notice: "Registration successfully created."
  else
    @registrations = @event.registrations.order(created_at: :desc)
    render "events/show", status: :unprocessable_entity
  end
end

  def edit
  end

  def update
    if @registration.update(registration_params)
      redirect_to @event, notice: "Registration updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @registration.destroy
    redirect_to @event, notice: "Registration deleted successfully."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_registration
    @registration = @event.registrations.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:attendee_name, :attendee_email)
  end
end
