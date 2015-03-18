require 'rails_helper'

RSpec.describe RocketDocs::Router do
  describe '#api_full' do
    api_full = RocketDocs::Router.api_full

    it 'returns a hash' do
      expect(api_full).to be_a(Hash)
    end

    context 'contains all' do
      it 'versions' do
        expect(api_full.keys).to eq [1, 2, 3, 4]
      end

      it 'controllers for every version' do
        expect(api_full[1].keys).to eq %w(api/v1/people)
        expect(api_full[2].keys).to eq %w(api/v2/people api/v2/posts)
        expect(api_full[3].keys).to eq %w(v3/people v3/posts)
      end

      it 'actions for every controller' do
        expect(api_full[1]['api/v1/people'][:actions].keys.to_set).to(
          eq(
            %w(index show new create edit update destroy).to_set
          )
        )
        expect(api_full[2]['api/v2/people'][:actions].keys.to_set).to(
          eq(
            %w(index show new create edit update destroy).to_set
          )
        )
        expect(api_full[2]['api/v2/posts'][:actions].keys.to_set).to(
          eq(
            %w(index show new create edit update destroy).to_set
          )
        )
        expect(api_full[3]['v3/people'][:actions].keys.to_set).to(
          eq(
            %w(index show new create edit update destroy).to_set
          )
        )
        expect(api_full[3]['v3/posts'][:actions].keys.to_set).to(
          eq(
            %w(index show new create edit update destroy).to_set
          )
        )
      end

      it 'methods for every action for every controller' do
        # TODO: Figure out a smart way to do this
        # without writing everything by hand
      end
    end
  end

  describe '#api_controller_names' do
    it 'returns all api controller names' do
      expected_result = [
        'api/v1/people', 'api/v2/posts', 'v3/people', 'v3/posts'
      ]
      expect(RocketDocs::Router.api_controller_names).to eq(expected_result)
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
      expect(RocketDocs::Router.api_controllers).to eq(expected_result)
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
      expect(RocketDocs::Router.api_controller_paths).to eq(expected_result)
    end
  end
end
