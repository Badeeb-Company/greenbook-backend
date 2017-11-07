class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable :recoverable, :rememberable, :trackable,
  devise :database_authenticatable, :registerable,
          :validatable, :confirmable, :recoverable

  has_secure_token :token

  has_many :shop_admins, inverse_of: :shop
  has_many :shops, through: :shop_admins

  has_many :reviews, dependent: :destroy
  has_many :owner_replies, dependent: :destroy, class_name: 'Review', foreign_key: :shop_owner_id

  has_many :shop_favourites, inverse_of: :shop
  has_many :favourites, through: :shop_favourites, source: :shop

  accepts_nested_attributes_for :shop_admins, allow_destroy: true
  
end
