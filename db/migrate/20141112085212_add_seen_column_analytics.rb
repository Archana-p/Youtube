class AddSeenColumnAnalytics < ActiveRecord::Migration
  def change
  	add_column :analytics , :seen , :boolean , :default => false
  end
end
