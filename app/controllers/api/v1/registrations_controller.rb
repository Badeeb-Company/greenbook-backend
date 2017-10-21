class Api::V1::RegistrationsController < Devise::RegistrationsController
	skip_before_action :authenticate_scope!
	before_action :authenticate_api_user!, only: [:update]

	def create
		@user = User.new(create_user_params)
		if @user.save
			render action: 'sign_up', status: :ok
		else
			@message = @user.errors
			render 'api/v1/empty', status: :unprocessable_entity
		end
	end

	def update
		@user = current_user
		if @user.update(update_user_params)
			render action: 'update', status: :ok
		else
			@message = @user.errors
			render 'api/v1/empty', status: :unprocessable_entity
		end
	end

	private

	def create_user_params
		params.require(:user).permit(:name,
			:email,
			:password,
			:image_url)
	end

	def update_user_params
		params.require(:user).permit(:name,
			:password,
			:image_url)
	end

end