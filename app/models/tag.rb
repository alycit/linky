class Tag < ActiveRecord::Base
  has_many :tag_clouds
  has_many :links, through: :tag_clouds
end
