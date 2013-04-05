class Post < ActiveRecord::Base
  has_many :sections
  accepts_nested_attributes_for :sections

  attr_accessible :title, :sections_attributes
  
  validates :title, presence:true
end
