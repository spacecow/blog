class SectionPresenter < BasePresenter
  presents :section

  def content
    h.content_tag :div, class: :content do
      h.markdown (section.content || '')
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
