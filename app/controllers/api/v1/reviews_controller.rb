class Api::V1::ReviewsController < Api::V1::BaseController
	before_action :authenticate_api_user!, except: [:index]
	before_action :set_shop!
	before_action :set_review!, only: [:destroy, :update, :reply]

	def index
		@reviews = @shop.reviews.order("created_at asc")
	end

	def create
		puts @shop.rate
		@review = Review.new(review_params.merge(user: current_user, shop: @shop))
		if !@review.save
			render_unprocessable(@review.errors.full_messages[0])
		end
	end

	def destroy
		if @review.destroy
			render 'shop_rate', status: :ok
		else
			render_unprocessable('Cannot delete this review')
		end
	end

	def update
		if @review.update(review_params)
			render 'shop_rate', status: :ok
		else
			render_unprocessable(@review.errors.full_messages[0])
		end
	end

	def reply
		@review.reply = params[:data][:reply_description]
		@review.shop_owner = current_user
		@review.date_replied = Time.now
		if @review.save
			render_empty_success
		else
			render_unprocessable(@review.errors.full_messages[0])
		end
	end


	private

	def set_shop!
		@shop = Shop.find_by_id(params[:shop_id])
		if !@shop.present?
			render_unprocessable('Shop not found')
		end
	end

	def set_review!
		@review = @shop.reviews.find_by_id(params[:id])
		if !@review.present?
			render_unprocessable('Review not found')
		end
	end

	def reply_review_params
		params.require(:data).permit(:reply_description)
	end

	def review_params
		params.require(:data).require(:review)
			.permit(:rate, :description)
	end

end