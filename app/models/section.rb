class Section < ActiveRecord::Base
  belongs_to :post
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  attr_accessible :content, :tag_tokens, :post_id

  validates :content, presence:true

  def post_title; post.try(:title) end

  def tag_tokens
    tags.map(&:id).join ', '
  end

  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

  class << self
    def tag_counts
      Tag.select("tags.id, tags.name, count(taggings.id) as count").joins(:taggings).group("tags.id").order(:name)
    end
  end
end
