class Api::V1::ShopsController < Api::V1::BaseController
	before_action :authenticate_api_user!, except: [:search, :index, :places, :show]
	before_action :set_shop!, only: [:add_favourite, :remove_favourite, :show]

	def search
		lat = params[:lat]
		lng = params[:lng]
		query = params[:query]

		if !valid_location?(lat, lng)
			render_unprocessable('Invalid location') and return
		end

		if !query
			query = 'restaurant'
		end

		google_result = GooglePlacesApi.search_places(lat, lng, query)
		@shops = []
		google_result.each do |place|
			shop = Shop.find_by_google_place_id(place.place_id)
			if !shop
				shop = Shop.initialize_from_place(place)
			end
			@shops << shop
		end
	end

	def show
	end

	def places
	    @client = GooglePlaces::Client.new('AIzaSyDw6Lr27FzIZX5vqLvIyt_XqxqtI6bb3ZE')
	    @places = @client.spots(-33.8670522, 151.1957362)
 	end

	def index
		@shops = []
		if params[:ids]
			ids = []
			params[:ids].split(',').each do |id|
				# ids << id.strip.to_i
				shop = Shop.find_by_google_place_id(id)
				if shop
					@shops << shop
				else
					place = GooglePlacesApi.get_place_detail(id)
					if place
						shop = Shop.initialize_from_place(place)
						@shops << shop
					end
				end
			end
			# @shops = Shop.where(google_place_id: ids)
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
		google_place_id = params[:id]
		@shop = Shop.find_or_create_by_place_id(google_place_id)
		if !@shop
			render_unprocessable('Shop not found')
		end
	end

	def valid_location?(lat, lng)
		lat && lng && (-90..90).include?(lat.to_f) && (-180..180).include?(lng.to_f)
	end

end