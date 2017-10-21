class Api::V1::PasswordsController < Devise::PasswordsController
  # layout "application", only: [:edit]
  
  respond_to :html

  def create
    self.resource = resource_class.send_reset_password_instructions(params['data'])
    if successfully_sent?(resource)
      render 'api/v1/empty', status: :ok, location: after_sending_reset_password_instructions_path_for(resource_name)
    else
      @message = 'No account matches this email'
      render 'api/v1/empty', status: :unauthorized
    end
  end

  protected

  def after_resetting_password_path_for(resource)
    root_path
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path
  end

end