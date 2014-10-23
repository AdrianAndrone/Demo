class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resources)
    new_user_profile_path(resources)
  end

end
