class Tagging < ActiveRecord::Base
  belongs_to :section
  belongs_to :tag

  attr_accessible :section_id, :tag_id
end
