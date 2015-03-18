require 'rails_helper'

RSpec.describe RocketDocs::Documentation do
  describe '#initialize' do
    it 'creates all the controllers' do
      doc = RocketDocs::Documentation.new(
        1, RocketDocs::Router.api_full[1]
      )
      expect(doc.controllers).to be_a Array
      expect(doc.controllers.map(&:full_name)).to eq %w(api/v1/people)
      expect(doc.controllers.map(&:name)).to eq %w(People)
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
