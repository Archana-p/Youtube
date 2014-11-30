class ChangeColumnToAnalytics < ActiveRecord::Migration
  def change
  	change_column :analytics , :like , :boolean 
  end
end
