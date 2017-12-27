class Shop < ApplicationRecord
	
	validates :name, presence: true

	has_many :photos, class_name: 'ShopPhoto', dependent: :destroy, inverse_of: :shop
	has_many :working_days, dependent: :destroy, inverse_of: :shop
	has_many :reviews, dependent: :destroy
	belongs_to :category, required: false

	has_many :shop_admins, dependent: :destroy
	has_many :admins, through: :shop_admins, class_name: 'User'

	has_many :shop_favourites, dependent: :destroy

	accepts_nested_attributes_for :photos, allow_destroy: true
	accepts_nested_attributes_for :working_days

	acts_as_mappable :lat_column_name => :lat, :lng_column_name => :long

	def self.find_or_create_by_place_id(google_place_id)
		shop = find_by_google_place_id(google_place_id)
		if !shop
			place = GooglePlacesApi.get_place_detail(google_place_id)
			if !place
				return nil
			end
			shop = initialize_from_place(place)
			if place.photos
				for i in 0...[3, place.photos.size].min
					shop.photos.append(ShopPhoto.new(photo_url: place.photos[i].fetch_url(400)))
				end
			end
			shop.save
		end
		return shop
	end

	def self.initialize_from_place(place)
		default_opened_at = Time.utc(2000, 10, 31, 9, 0)
		default_closed_at = Time.utc(2000, 10, 31, 22, 0)
		main_photo_url = place.icon
		if(place.photos[0])
			main_photo_url = place.photos[0].fetch_url(800)
		end
		shop = Shop.new(lat: place.lat, long: place.lng, google_place_id: place.place_id,
			name: place.name, address: place.vicinity, phone_number: place.formatted_phone_number,
			main_photo_url: main_photo_url,
			working_days_attributes: [
					{day_name: 'Saturday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Sunday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Monday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Tuesday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Wednesday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Thursday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Friday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'}
				])
	end

	def self.new_with_working_days
		default_opened_at = Time.utc(2000, 10, 31, 9, 0)
		default_closed_at = Time.utc(2000, 10, 31, 22, 0)
		shop = Shop.new(
			working_days_attributes: [
					{day_name: 'Saturday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Sunday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Monday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Tuesday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Wednesday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Thursday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'},
					{day_name: 'Friday', opened_at: default_opened_at, closed_at: default_closed_at, state: 'opened'}
				]
			)
		shop
	end

end
