class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.integer :video_id
     
      t.integer :user_id
     
      t.integer :like

      t.timestamps
    end
  end
end
