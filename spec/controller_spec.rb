require 'rails_helper'

RSpec.describe RocketDocs::Documentation::Controller do
  controller = RocketDocs::Documentation.new(
    'v1', RocketDocs::Router.api_full[1]
  ).controllers.first

  describe '#initialize' do
    it 'creates all the actions' do
      expect(controller.actions.map(&:name).to_set).to(
        eq(
          %w(index show new create edit update destroy).to_set
        )
      )
    end
  end

  describe '#name' do
    it 'returns the class name of the controller' do
      expect(controller.name).to eq 'People'
    end
  end

  describe '#full_name' do
    it 'returns the full namespaced class name of the controller' do
      expect(controller.full_name).to eq 'api/v1/people'
    end
  end

  describe '#should_update?' do
    # TODO: Figure out how to test this
  end

  describe '#update' do
    # TODO: Figure out how to test this
  end

  describe '#update!' do
    # TODO: Figure out how to test this
  end
end
