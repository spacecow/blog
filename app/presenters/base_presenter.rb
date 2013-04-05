class BasePresenter
  def initialize object, parent=nil, grandparent=nil, template
    @object   = object
    @template = template
  end

  def h; @template end

  class << self
    def presents name
      define_method name do
        @object 
      end
    end
  end
end
