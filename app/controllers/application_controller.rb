class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

   def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      events_path
    end
  end

  # Redirect after sign up
  def after_sign_up_path_for(resource)
    events_path
  end
end
