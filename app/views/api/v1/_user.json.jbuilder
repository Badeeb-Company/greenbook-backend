json.user do
	json.extract! user, :id, :name, :email, :image_url, :token
	json.owned_shops Array.new
end