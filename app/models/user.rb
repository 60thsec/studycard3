class User < ActiveRecord::Base
  has_secure_password
  has_many :decks
  validates :username, presence: true, uniqueness: true, length: {in: 3..16}
  validates :password, presence: true, length: {minimum: 6}
  validates :auth_token, uniqueness: true
end
