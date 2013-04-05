class Tag < ActiveRecord::Base
  has_many :tagships
  has_many :sections, through: :tagships

  attr_accessible :name
end
