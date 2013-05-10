class PostPresenter < BasePresenter
  presents :post

  def form
    h.render 'posts/form', post:post
  end

  def posts _posts
    h.render _posts
  end

  def sections
    _sections = post.sections
    h.render 'sections/sections', sections:_sections if _sections.present?
  end

  def title options = {}
    if options[:as] == :link
      h.link_to post.title, post
    else
      h.content_tag :h1 do
        post.title
      end
    end
  end
end
