class ChangeColumnTypeAnalytics < ActiveRecord::Migration
  def change
  	change_column :analytics , :like , :boolean ,:default => true
  end
end
