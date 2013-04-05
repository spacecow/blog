require 'spec_helper'

describe Post do
  it 'title cannot be blank' do
    lambda{ create :post, title:'' }.should raise_error ActiveRecord::RecordInvalid, 'Validation failed: Title can\'t be blank'
  end
end
