class User < ActiveRecord::Base
	has_many :posts

	has_secure_password

	validates :username, uniqueness: true, presence: true
	validates :password_digest , length: { minimum: 10 }, presence: true
end
