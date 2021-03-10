class User < ActiveRecord::Base

  has_secure_password

  has_many :shops
  has_many :sales, through: :shops

end