ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseRewinder.strategy = :truncation
  end

  config.before(:each) do
    DatabaseRewinder.start
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end

  config.before(:all) do
    FactoryGirl.reload
  end

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
