class Post < ActiveRecord::Base
  has_many :sections
  accepts_nested_attributes_for :sections, :reject_if => lambda{|e| e[:content].blank? }

  validates :title, presence:true
end
