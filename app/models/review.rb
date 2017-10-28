class Review < ApplicationRecord
  # belongs_to :user
  # belongs_to :shop_owner, foreign_key: "shop_owner_id"
  belongs_to :shop

  belongs_to :user, class_name: 'User'
  belongs_to :shop_owner, class_name: 'User', required: false

  after_save :calculate_shop_rate
  after_destroy :calculate_shop_rate

  private

  def calculate_shop_rate
  	average_rate = self.shop.reviews.average(:rate)
    self.shop.update(rate: average_rate)
  end

end
