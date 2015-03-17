require 'rails_helper'

RSpec.describe RocketDocs::Documentation::Action do
  action = RocketDocs::Documentation.new(
          'v1', RocketDocs::Router.api_full['v1']
        ).controllers.first.actions.select { |a| a.name == 'create' }.first

  describe '#url' do
    it 'returns the actions URL for a given method' do
      expect(action.url('POST')).to eq '/api/v1/people'
      expect(action.url('GET')).to eq '/api/v1/people'
      expect(action.url('PUT')).to eq '/api/v1/people'
    end
  end

  describe '#description' do
    it 'returns the action\'s description for each method' do
      desc = 'Praesent maximus, leo a maximus fringilla, urna felis '\
             'sollicitudin nunc, eu pulvinar est urna eu justo. Phasellus '\
             'quis hendrerit nibh. Praesent id nunc ac augue ultricies rutrum '\
             'at vel quam.'
      expect(action.description('POST')).to eq desc
      expect(action.description('GET')).to eq desc
      expect(action.description('PUT')).to eq desc
    end
  end

  describe '#params' do
    it 'returns a hash of params for a given method the action expects' do
      expect(action.params('POST')).to(eq(
        'id' => 'integer',
        'age' => 'integer',
        'name' => 'string',
        'additional' => {
          'likes_cookies' => 'boolean',
          'likes_top_gear' => 'boolean',
          'language' => {
            'name' => 'string',
            'level_of_knowlage' => 'string (A1, A2, B1, B2, C1, C2)'
          }
        }
      ))

      expect(action.params('GET')).to(eq(
        'id' => 'integer'
      ))
    end
  end

  describe '#default_method' do
    it 'returns the default method the action responds to' do
      expect(action.default_method).to eq 'POST'
    end
  end

  describe '#methods' do
    it 'returns the methods to which the action responds to' do
      expect(action.methods.to_set).to eq %w(POST).to_set
    end
  end
end
