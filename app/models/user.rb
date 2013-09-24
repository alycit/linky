class User < ActiveRecord::Base
	has_many :links
	has_many :tags, through: :links

	validates_uniqueness_of :user_id
	end
