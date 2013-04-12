class TagPresenter < BasePresenter
  presents :tag

  def branch
    tag.branch.map{|e| h.link_to e.name, e}.join(' > ').html_safe
  end

  def name
    h.link_to tag.name, tag
  end

  def sections
    h.render 'sections/sections', sections:tag.sections
  end

  def tags _tags; h.render _tags end
end
