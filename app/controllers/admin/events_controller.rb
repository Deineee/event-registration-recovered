class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [:show, :edit, :update]

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def bulk_destroy
    Event.where(id: params[:event_ids]).destroy_all
    redirect_to admin_events_path, notice: "Selected events were deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :location, :description, :status)
  end
end
