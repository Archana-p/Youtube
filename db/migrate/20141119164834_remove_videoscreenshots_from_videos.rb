class RemoveVideoscreenshotsFromVideos < ActiveRecord::Migration
  def change
  	remove_column :videos, :videos_screenshot, :string
  end
end
