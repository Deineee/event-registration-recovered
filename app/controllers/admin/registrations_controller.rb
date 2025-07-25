class Admin::RegistrationsController < Admin::BaseController
  def index
    @q = Registration.ransack(params[:q])
    @registrations = @q.result.includes(:event).order(created_at: :desc).page(params[:page])
  end

  def bulk_destroy
    Registration.where(id: params[:registration_ids]).destroy_all
    redirect_to admin_registrations_path, notice: "Selected registrations were deleted."
  end

  def export
    @registrations = Registration.all
    send_data @registrations.to_csv, filename: "registrations-#{Date.today}.csv"
  end
end
