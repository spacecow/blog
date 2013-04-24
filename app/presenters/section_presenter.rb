class SectionPresenter < BasePresenter
  presents :section

  def content
    _content = section.content
    h.content_tag :div, class: :content do
      _content.gsub!(/->(\d+)/){ Section.exists?($1) ? h.render(Section.find($1)) : 'XXXXX Section id does not exist! XXXXX' } if _content
      h.markdown (_content || '')
    end
  end

  def form
    h.render 'sections/form', section:section
  end

  def post
    h.content_tag :h1 do
      _post = section.post
      if _post
        h.link_to _post.title, _post
      end
    end
  end

  def sections _sections
    h.render _sections
  end

  def tags
    h.render 'tags/tags', tags:section.tags
  end
end
