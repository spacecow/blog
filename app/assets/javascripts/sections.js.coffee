jQuery ->
  for i in [0..9]
    post_tags_id = "#post_sections_attributes_#{i}_tag_tokens"
    $(post_tags_id).tokenInput '/tags.json',
      theme: 'facebook'
      prePopulate: $(post_tags_id).data('load')

  section_tags_id = "#section_tag_tokens"
  $(section_tags_id).tokenInput '/tags.json',
    theme: 'facebook'
    prePopulate: $(section_tags_id).data('load')
