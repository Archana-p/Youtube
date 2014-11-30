class AddId < ActiveRecord::Migration
  def up
  add_column :comments ,:video_id ,:integer
  add_column :comments ,:user_id , :integer
  end
  def down
  end

end
