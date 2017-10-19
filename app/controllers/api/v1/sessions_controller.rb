class Api::V1::SessionsController < Devise::SessionsController
	# include Api::AuthenticationHelper
	layout 'base'

	skip_before_action :verify_authenticity_token
	skip_before_action :verify_signed_out_user


	def create
		@user = User.find_for_database_authentication(:email => params[:user][:email])
		if @user.present? and @user.valid_password?(params[:user][:password])
			render action: 'sign_in', status: :ok
		else
			@message = 'Login failed, invalid email or password'
			render 'api/v1/empty', status: :unauthorized
		end
	end

	def destroy
		current_user = find_user_by_token
		if(!current_user.present?)
			return unauthorized
		end
		respond_to do |format|
			format.json { render json: {message: "logged out"}, status: :ok }
		end
	end

end
