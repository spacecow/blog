module NavigationHelper
  def nav_tab title, path:path, current:current
    _class = current == title ? 'active' : 'inactive'
    content_tag :li, link_to(title,path), class:_class
  end
end
