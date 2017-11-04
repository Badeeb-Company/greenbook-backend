json.shops @shops do |shop|
	json.partial! "shop", shop: shop
end