class Post < ActiveRecord::Base
	belongs_to :user

	validates :title, presence: true
	validates :url, presence: true
	validates :text,length: { maximum: 100 }, presence: true
end
