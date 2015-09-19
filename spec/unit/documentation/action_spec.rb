require 'rails_helper'

RSpec.describe RocketDocs::Documentation::Action do
  create_action = RocketDocs::Documentation
                  .new('v1', RocketDocs::Router.api_full[1])
                  .controllers.first.actions
                  .select { |a| a.name == 'create' }.first

  describe '#url' do
    it 'returns the actions URL for a given method' do
      expect(create_action.url('POST')).to eq '/api/v1/people'
      expect(create_action.url('GET')).to eq '/api/v1/people'
      expect(create_action.url('PUT')).to eq '/api/v1/people'
    end
  end

  describe '#description' do
    it 'returns the action\'s description for each method' do
      desc = 'Praesent maximus, leo a maximus fringilla, urna felis '\
             'sollicitudin<br>nunc, eu pulvinar est urna eu justo. Phasellus '\
             'quis hendrerit nibh.<br>Praesent id nunc ac augue ultricies '\
             'rutrum at vel quam.'
      expect(create_action.description('POST')).to eq desc
      expect(create_action.description('GET')).to eq desc
      expect(create_action.description('PUT')).to eq desc
    end
  end

  describe '#params' do
    it 'returns a hash of params for a given method the action expects' do
      expect(create_action.params('POST')).to(
        eq(
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
        )
      )

      expect(create_action.params('GET')).to(
        eq(
          'id' => 'integer'
        )
      )
    end
  end

  describe '#methods' do
    it 'returns the methods to which the action responds to' do
      expect(create_action.methods.to_set).to eq %w(POST).to_set
    end
  end

  describe '#example' do
    edit_action = RocketDocs::Documentation
                  .new('v1', RocketDocs::Router.api_full[1])
                  .controllers.first.actions
                  .select { |a| a.name == 'edit' }.first

    it 'returns the action\'s example for each method' do
      expect(edit_action.example('GET')).to(
        eq(
          "{\n"\
          "  \"title\": \"Exactly nothing!\",\n  \"content\": \"Go away!\"\n"\
          "}\n"
        )
      )
    end
  end
end
