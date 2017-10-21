class Api::V1::ConfirmationsController < Devise::ConfirmationsController

   respond_to :html

   def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      render 'api/v1/confirmations/confirm'
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

end
