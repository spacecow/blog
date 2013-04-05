class PostPresenter < BasePresenter
  presents :post

  def edit_link
    h.link_to 'Edit Post', h.edit_post_path(post)
  end

  def form
    h.render 'posts/form', post:post
  end

  def sections
    _sections = post.sections
    h.render 'sections/sections', sections:_sections if _sections.present?
  end

  def title
    h.content_tag :h1 do
      post.title
    end
  end
end
