class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :user_id
  		t.string :display_name
  		t.string :first_name
  		t.string :last_name
  		t.string :profile_image
  		t.timestamps
  	end

  end
end
