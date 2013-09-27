class Tag < ActiveRecord::Base
  has_many :tag_clouds
  has_many :links, through: :tag_clouds

  validates :text, uniqueness: true

  def self.find_links_by_tag_and_user(text, user_id)
  	tag = self.find_by_text(text)
  	tag.nil? ? [] : tag.links.where(user_id: user_id) 
  end
end
