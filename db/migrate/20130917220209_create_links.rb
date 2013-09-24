class CreateLinks < ActiveRecord::Migration
  def change
  	create_table :links do |t|
  		t.string :url
  		t.string :description
  		t.string :thumbnail_image
  		t.belongs_to :user
  		t.timestamps
  	end
  end
end
