class Shop < ApplicationRecord
	validates :name, :description, presence: true

	has_many :photos, class_name: 'ShopPhoto', dependent: :destroy, inverse_of: :shop
	has_many :working_days, dependent: :destroy, inverse_of: :shop
	belongs_to :category

	acts_as_mappable :lat_column_name => :lat, :lng_column_name => :long

	def initialize(attributes={})
		super
		self.category = Category.first
		self.working_days.append(
			WorkingDay.new(day_name: 'Saturday', opened_at: 0, closed_at: 0, state: 'opened'),
			WorkingDay.new(day_name: 'Sunday', opened_at: 0, closed_at: 0, state: 'opened'),
			WorkingDay.new(day_name: 'Monday', opened_at: 0, closed_at: 0, state: 'opened'),
			WorkingDay.new(day_name: 'Tuesday', opened_at: 0, closed_at: 0, state: 'opened'),
			WorkingDay.new(day_name: 'Wednesday', opened_at: 0, closed_at: 0, state: 'opened'),
			WorkingDay.new(day_name: 'Thursday', opened_at: 0, closed_at: 0, state: 'opened'),
			WorkingDay.new(day_name: 'Friday', opened_at: 0, closed_at: 0, state: 'opened')
			)
	end

end
