ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../test_app/config/environment", __FILE__)
require 'rspec/rails'

if Rails::VERSION::STRING >= '4.1.8'
  ActiveRecord::Migration.maintain_test_schema!
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
