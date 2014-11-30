class CreateShareVideos < ActiveRecord::Migration
  def up
    create_table :user_videos do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
  end

  def down
  	 drop_table :share_videos 
    
  end
end
