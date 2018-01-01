json.extract! shop, :id, :name, :rate, :phone_number, :main_photo_url, :open_now
json.num_of_reviews shop.reviews.size
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
	json.extract! working_day, :day_name, :state
	json.opened_at working_day.opened_at.strftime("%I:%M %p")
	json.closed_at working_day.closed_at.strftime("%I:%M %p")
end