class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @events = current_user.events.order(created_at: :desc)
  end

  def show
    @registrations = @event.registrations.order(created_at: :desc)
    @registration = @event.registrations.build
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path, notice: "Event created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: "Event updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event deleted successfully."
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :location, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    redirect_to events_path, alert: "You are not authorized to perform this action." unless @event.user == current_user
  end
end

