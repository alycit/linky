class User < ActiveRecord::Base
	has_many :links
	has_many :tags, through: :links

	validates_uniqueness_of :user_id

	def add_link_with_tags(url, description, tags_input)
		new_link = Link.create(url: url, user_id: id, description: description, tags: create_tags(tags_input))
		new_link.errors if !new_link.errors.empty?
	end

	private

	def create_tags(tags_input)
		new_tags = []
	  tags_input.each do |tag|
	    new_tag = Tag.find_by_text(tag)
	    new_tag.nil? ? new_tags << Tag.create(text: tag) : new_tags << new_tag
	  end

	  new_tags
	end
end
