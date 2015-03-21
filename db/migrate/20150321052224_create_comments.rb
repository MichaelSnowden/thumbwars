class CreateComments < ActiveRecord::Migration
  def change
  	drop_table :comments
    create_table :comments do |t|
    	t.string :ancestry
    	t.text :content
    	t.belongs_to :user
    	t.belongs_to :post

      t.timestamps null: false
    end
    add_index :comments, :ancestry
  end
end
