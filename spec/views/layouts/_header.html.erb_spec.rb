require 'spec_helper'

describe 'layouts/_header.html.erb' do
  let(:rendering){ Capybara.string rendered }
  before{ render 'layouts/header' }
  it{ response.should render_template 'layouts/_navigation' }
end
