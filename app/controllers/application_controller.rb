class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name, :feasibility_threshold, :adjustment_delta,
                                             { feasibility_levels_attributes: %i[id title value linguistic] }])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:name, :feasibility_threshold, :adjustment_delta,
                                             { feasibility_levels_attributes: %i[id title value linguistic] }])
  end
end
