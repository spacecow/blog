require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

    #focus tag
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    #factorygirl shortcut
    config.include FactoryGirl::Syntax::Methods

    #Include presenters
    config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}
  end

  def blank_error
    [ActiveRecord::RecordInvalid, /^Validation failed: [\w ]+ can't be blank$/]
  end

  def confirmation_error
    [ActiveRecord::RecordInvalid, /^Validation failed: [\w ]+ doesn\'t match [\w ]+$/]
  end

  def duplication_error
    [ActiveRecord::RecordInvalid, /^Validation failed: [\w ]+ has already been taken$/]
  end

  def invalid_error
    [ActiveRecord::RecordInvalid, /^Validation failed: [\w ]+ is invalid$/]
  end
end

Spork.each_run do
  FactoryGirl.reload
end

