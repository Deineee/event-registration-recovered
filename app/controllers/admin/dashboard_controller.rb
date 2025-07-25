class Admin::DashboardController < Admin::BaseController
  def index
    @total_events = Event.count
    @total_registrations = Registration.count
    @recent_events = Event.order(created_at: :desc).limit(5)
    @recent_registrations = Registration.order(created_at: :desc).limit(5)
  end
end
