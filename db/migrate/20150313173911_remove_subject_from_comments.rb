class RemoveSubjectFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :subject
  end
end
