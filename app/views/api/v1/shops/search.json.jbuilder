json.shops @shops do |shop|
	json.extract! shop, :id, :name, :description, :rate, :phone_number, :main_photo_url
	json.location do
		json.extract! shop, :long, :lat, :address
	end
	if shop.category
		json.category do
			json.extract! shop.category, :id, :name
		end
	end
	json.photos shop.photos do |photo|
		json.extract! photo, :id, :photo_url
	end
	json.working_days shop.working_days do |working_day|
		json.extract! working_day, :day_name, :opened_at, :closed_at, :state
	end
end