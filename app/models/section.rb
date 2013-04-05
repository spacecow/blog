class Section < ActiveRecord::Base
  belongs_to :post
  has_many :tagships
  has_many :tags, through: :tagships

  attr_accessible :content, :tag_tokens
  attr_reader :tag_tokens

  def tag_tokens=(ids)
    self.tag_ids = ids.split(",")
  end
end
