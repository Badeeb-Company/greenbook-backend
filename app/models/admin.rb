class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, recoverable, :rememberable, :trackable, :registerable
  devise :database_authenticatable, :validatable, :rememberable
end
