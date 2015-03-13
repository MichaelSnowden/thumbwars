class Post < ActiveRecord::Base
	acts_as_commentable
	belongs_to :user
	acts_as_votable
end
