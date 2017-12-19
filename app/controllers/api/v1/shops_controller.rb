class Api::V1::ShopsController < Api::V1::BaseController
	before_action :authenticate_api_user!, except: [:search, :index]
	before_action :set_shop!, only: [:add_favourite, :remove_favourite]

	def search
		@shops = Shop.all.order("name asc")
		category_id = params[:category_id]
		lat = params[:lat]
		lng = params[:lng]
		if !valid_location?(lat, lng)
			render_unprocessable('Invalid location') and return
		end
		@shops = Shop.where(category_id: category_id)
			.order("name asc")
	end

	def index
		@shops = nil
		if params[:ids]
			ids = []
			params[:ids].split(',').each do |id|
				ids << id.strip.to_i
			end
			@shops = Shop.where(id: ids)
		else
			@shops = Shop.all
		end
	end

	def add_favourite
		shop_favourite = ShopFavourite.new(shop: @shop, user: current_user)
		if shop_favourite.save
			render_empty_success
		else
			render_unprocessable(shop_favourite.errors.full_messages[0])
		end
	end

	def remove_favourite
		shop_favourite = current_user.shop_favourites.find_by_shop_id(@shop.id)
		if shop_favourite
			shop_favourite.destroy
			render_empty_success
		else
			render_unprocessable('This shop is not in user favourites')
		end
	end

	def favourites
		@favourites = current_user.favourites
	end


	private

	def set_shop!
		@shop = Shop.find_by_id(params[:id])
		if !@shop.present?
			render_unprocessable('Shop not found')
		end
	end

	def valid_location?(lat, lng)
		lat && lng && (-90..90).include?(lat.to_f) && (-180..180).include?(lng.to_f)
	end

end