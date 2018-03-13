class Api::V1::PasswordsController < Devise::PasswordsController
  include Api::V1::AuthenticationHelper
  respond_to :json
  layout 'base', only: :create
  
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by_email(params['data']['email'])
    if user && user.account_type != 'email'
      @message = "You used #{user.account_type} to register. Cannot reset password."
      render 'api/v1/empty', status: :unprocessable_entity
      return
    end

    self.resource = resource_class.send_reset_password_instructions(params['data'])
    if successfully_sent?(resource)
      render 'api/v1/empty', status: :ok
    else
      @message = 'No account matches this email'
      render 'api/v1/empty', status: :unauthorized
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def after_resetting_password_path_for(resource)
    api_v1_users_password_changed_path
  end

  def require_no_authentication
  end

end
