class Api::V1::ConfirmationsController < Devise::ConfirmationsController

   def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      render 'api/v1/confirmations/confirm'
    else
      render 'api/v1/confirmations/confirm'
    end
  end

end
