class CreateTagCloud < ActiveRecord::Migration
  def change
  	create_table :tag_clouds do |t|
  		t.references :tag
  		t.references :link
  	end
  end
end
