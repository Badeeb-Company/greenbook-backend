json.places @places do |place|
	json.extract! place, :name, :lat, :lng, :reference, :icon, :vicinity, :types, 
		:formatted_phone_number, :formatted_address, :address_components, :rating, :url
end