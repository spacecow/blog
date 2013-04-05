class SectionPresenter < BasePresenter
  presents :section

  def content
    h.markdown (section.content || '')
  end

  def sections _sections
    h.render _sections
  end
end
