class Api::V1::SessionsController < Devise::SessionsController
	skip_before_action :verify_signed_out_user
	before_action :authenticate_api_user!, only: :destroy


	def create
		@user = User.find_for_database_authentication(:email => params[:data][:email])
		if @user.present? and @user.valid_password?(params[:data][:password])
			render action: 'sign_in', status: :ok
		else
			@message = 'Login failed, invalid email or password'
			render 'api/v1/empty', status: :unauthorized
		end
	end

	def destroy
		render 'api/v1/empty', status: :ok
	end

end
