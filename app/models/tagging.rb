class Tagging < ActiveRecord::Base
  belongs_to :section
  belongs_to :tag
end
