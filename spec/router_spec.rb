require 'rails_helper'

RSpec.describe Interdasting::Router do
  describe '#api_controller_names' do
    it 'returns all api controller names' do
      expected_result = [
        'api/v1/people', 'api/v2/posts', 'v3/people', 'v3/posts'
      ]
      expect(Interdasting::Router.api_controller_names).to eq(expected_result)
    end
  end

  describe '#api_controllers' do
    it 'returns all api controller classes' do
      expected_result = [
        Api::V1::PeopleController,
        Api::V2::PostsController,
        V3::PeopleController,
        V3::PostsController
      ]
      expect(Interdasting::Router.api_controllers).to eq(expected_result)
    end
  end

  describe '#api_controller_paths' do
    it 'returns the file path to all api controllers' do
      root = File.expand_path('..', __FILE__)
      expected_result = [
        '/test_app/app/controllers/api/v1/people_controller.rb',
        '/test_app/app/controllers/api/v2/posts_controller.rb',
        '/test_app/app/controllers/v3/people_controller.rb',
        '/test_app/app/controllers/v3/posts_controller.rb'
      ]
      expected_result = expected_result.map { |r| root + r }
      expect(Interdasting::Router.api_controller_paths).to eq(expected_result)
    end
  end
end
