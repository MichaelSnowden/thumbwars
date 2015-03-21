class Comment < ActiveRecord::Base
  has_ancestry
  acts_as_votable

  belongs_to :post
  belongs_to :user
end
