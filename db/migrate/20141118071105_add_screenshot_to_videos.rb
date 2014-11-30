class AddScreenshotToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :videos_screenshot, :string
  end
end
