class RemoveTitleFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :title
  	rename_column :comments, :body, :content
  end
end
