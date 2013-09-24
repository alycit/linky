class Link < ActiveRecord::Base
	belongs_to :user
	has_many :tag_clouds
	has_many :tags, through: :tag_clouds

	validates_uniqueness_of :url
end
