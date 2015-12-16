class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: {in: 3..16}
end
