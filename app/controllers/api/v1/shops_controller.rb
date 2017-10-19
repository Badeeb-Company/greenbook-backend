class Api::V1::ShopsController < Api::V1::BaseController

	def search
		@shops = Shop.all.order("name asc")
	end

end