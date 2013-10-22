class Link < ActiveRecord::Base
	belongs_to :user
	has_many :tag_clouds
	has_many :tags, through: :tag_clouds

	validates :url, url: true, unique_user_url: true
end
