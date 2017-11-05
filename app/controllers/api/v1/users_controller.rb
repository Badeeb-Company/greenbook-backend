class Api::V1::UsersController < Api::V1::BaseController

	def social_login
		# check if user was already registered
		@user = User.where(account_id: social_login_params[:account_id],
			account_type: social_login_params[:account_type]).first

		# return user data if it was already registered
		if @user
			@user.update(account_token: social_login_params[:account_token])
			render 'api/v1/registrations/sign_up', status: :ok and return
		end

		# insert a new user
		if !social_login_params[:email]
			social_login_params[:email] = social_login_params[:account_id] + "@greenbook.com"
		end
		generated_password = Devise.friendly_token
		@user = User.new(social_login_params.merge(password: generated_password))
		@user.skip_confirmation!
		if @user.save
			render 'api/v1/registrations/sign_up', status: :ok
		else
			@message = @user.errors
			render 'api/v1/empty', status: :unprocessable_entity
		end
	end

	private

	def social_login_params
		params.require(:data).require(:user).permit(:account_type,
			:account_id,
			:account_token,
			:image_url,
			:email,
			:name)
	end

end