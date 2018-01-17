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
			save_photos_from_place(shop, place)
			save_working_days_from_place(shop, place)
			shop.save
		end
		return shop
	end

	def self.save_working_days_from_place(shop, place)
		if place.opening_hours
			weekday_texts = place.opening_hours['weekday_text']
			if weekday_texts
				weekday_texts.each_with_index do |text, i|
					shop.working_days[i].opening_hours = text
				end
			end
		end
	end

	def self.save_photos_from_place(shop, place)
		if place.photos
			for i in 0...[3, place.photos.size].min
				shop.photos.append(ShopPhoto.new(photo_url: place.photos[i].fetch_url(400)))
			end
		end
	end

	def self.initialize_from_place(place)
		main_photo_url = place.icon
		if(place.photos[0])
			main_photo_url = place.photos[0].fetch_url(800)
		end
		shop = Shop.new(lat: place.lat, long: place.lng, google_place_id: place.place_id,
			name: place.name, address: place.vicinity, phone_number: place.formatted_phone_number,
			main_photo_url: main_photo_url, website: place.website)
		add_default_working_days(shop)
		shop
	end

	def self.new_with_working_days
		shop = Shop.new
		add_default_working_days(shop)
		shop
	end

	def self.add_default_working_days(shop)
		shop.working_days << create_working_day('Monday')
		shop.working_days << create_working_day('Tuesday')
		shop.working_days << create_working_day('Wednesday')
		shop.working_days << create_working_day('Thursday')
		shop.working_days << create_working_day('Friday')
		shop.working_days << create_working_day('Saturday')
		shop.working_days << create_working_day('Sunday')
	end

	def self.create_working_day(name)
		WorkingDay.new(day_name: name, opening_hours: 'Open from 12:00 PM - 12:00 AM')
	end

end
