jQuery ->
  for i in [0..1]
    tags_id = "#post_sections_attributes_#{i}_tag_tokens"
    $(tags_id).tokenInput '/tags.json',
      theme: 'facebook'
      prePopulate: $(tags_id).data('load')
