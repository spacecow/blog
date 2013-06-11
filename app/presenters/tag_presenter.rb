class TagPresenter < BasePresenter
  presents :tag

  def branch
    tag.branch.map{|e| h.link_to e.leaf_name, e}.join(' > ').html_safe
  end

  def form
    h.render 'tags/form', tag:tag
  end

  def leaf_name
    h.link_to tag.leaf_name, tag
  end

  def sections
    h.render 'sections/sections', sections:tag.sections
  end

  def tags _tags
    _tags.map do |_tag|
      h.render(_tag).html_safe.strip
    end.join(', ').html_safe
  end
end
