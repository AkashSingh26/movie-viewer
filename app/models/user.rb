class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable,
         jwt_revocation_strategy: JwtDenylist
  

  has_many :ratings, dependent: :destroy
  has_many :recommendations, dependent: :destroy
  has_many :jwt_denylist, dependent: :destroy
end
