class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	acts_as_votable
	acts_as_taggable

	validates_presence_of :title
	validates_presence_of :content
	validates_presence_of :tag_list
	validates_length_of :title, minimum: 1, message: "missing title"
	validates_length_of :content, minimum: 1, message: "missing content"
	validate :tag_list_count

	def votable
		created_at > 1.week.ago 
	end
	def self.search(query)
		where("title ilike?", "%#{query}%")
	end
	def tag_list_count
		errors[:tag_list] << "1 tags minimum" if tag_list.count < 1
		errors[:tag_list] << "5 tags maximum" if tag_list.count > 5
	end
end
