class Comment < ActiveRecord::Base
  has_ancestry
  acts_as_votable

  belongs_to :post
  belongs_to :user

  def css_class
  	if has_children?
  		"comment-has-children"
  	else
  		""
  	end
  end

  def score
    get_likes.size - get_dislikes.size
  end
end
