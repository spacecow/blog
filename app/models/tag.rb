class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :sections, through: :taggings

  attr_accessible :name, :parent_id

  validates :name, presence:true, uniqueness:true

  has_ancestry

  def branch
    [ancestors,self].flatten
  end

  class << self
    def ids_from_tokens tokens
      tokens.gsub!(/<<<(.+?)>>>/){ create_tags($1).id }
      tokens.split ','
    end 

    def tokens query
      where("name like ?", "%#{query}%") + [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    end

    private
  
      def create_tags tags
        return nil if tags.nil?
        rest, tag_s = pop_tag tags 
        parent = create_tags rest
        tag = find_by_name tag_s
        if tag.nil?
          tag = create name:tag_s, parent_id:parent.try(:id)
        elsif parent.try(:id) != tag.ancestry
          tag.parent_id = parent.id
          tag.save
        end
        tag
      end

      def pop_tag tags
        tags.match(/(?:(.*)\/)?(.*)/).captures
      end
  end
end
