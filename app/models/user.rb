class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable :recoverable, :rememberable, :trackable,
  devise :database_authenticatable, :registerable,
          :validatable, :confirmable

  has_secure_token :token
  
end
