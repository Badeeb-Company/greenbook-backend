class Api::V1::RegistrationsController < Devise::RegistrationsController
	layout 'base'

	skip_before_action :authenticate_scope!
	skip_before_action :verify_authenticity_token
	# before_action :authenticate_api_user!, only: [:update, :edit]

	def create
		@user = User.new(user_params)
		if @user.save
			render action: 'sign_up', status: :ok
		else
			@message = @user.errors
			render 'api/v1/empty', status: :unprocessable_entity
		end
	end

	def update
		@user = current_user
		if @user.update(user_params)
			render action: 'update', status: :ok
		else
			@message = @user.errors
			render 'api/v1/empty', status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:name,
			:email,
			:password,
			:image_url)
	end

end