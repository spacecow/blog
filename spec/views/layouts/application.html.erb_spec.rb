require 'spec_helper'

describe 'layouts/application' do
  let(:rendering){ Capybara.string rendered }
  before{ render }
  it{ response.should render_template 'layouts/_header' }
end
