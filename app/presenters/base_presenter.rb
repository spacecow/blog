class BasePresenter
  def initialize object, parent=nil, grandparent=nil, template
    @object   = object
    @template = template
  end

  def h; @template end

  def actions *options
    object = @object.class.to_s.downcase
    object = @object.to_s.downcase.pluralize if object == 'class'
    h.content_tag :div, class:[:actions, object] do
      links *options 
    end
  end

  def current_tab
    h.content_for(:current_tab){ h.pl(singular) }
  end

  def delete_link label = nil
    object = @object.class.to_s.downcase
    lbl = label || h.delete(object.to_sym)
    h.link_to lbl, @object, method: :delete, class:[:delete,object]
  end

  def edit_link label = nil
    object = @object.class.to_s.downcase
    lbl = label || h.edit(object.to_sym)
    h.link_to lbl, h.send("edit_#{object}_path", @object), class:[:edit, object]
  end

  def new_link label = nil
    object = @object.to_s.downcase
    lbl = label || h.new(object.to_sym)
    h.link_to lbl, h.send("new_#{object}_path"), class:[:new, object]
  end

  def singular
    @object.to_s.downcase
  end

  def view_link label = nil
    object = @object.class.to_s.downcase
    lbl = label || h.view(object.to_sym)
    h.link_to lbl, @object, class:[:view, object]
  end

  def links *arr
    if arr.length == 1
      send "#{arr.first}_link"
    elsif arr.length > 1
      object = @object.class.to_s.downcase
      ("("+arr.map{|e| send "#{e}_link", h.t(e)}.join(' | ')+") #{h.sg object}").html_safe
    end
  end

  class << self
    def presents name
      define_method name do
        @object 
      end
    end
  end
end
