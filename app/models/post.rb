class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	acts_as_votable
	acts_as_taggable
end
