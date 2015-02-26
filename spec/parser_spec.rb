require 'rails_helper'

RSpec.describe Interdasting::Parser do
  # Expected comments
  expected_index_comments = <<-EOF
Doc
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
  gravida convallis aliquam. Duis pellentesque bibendum ipsum, vel
  imperdiet metus tincidunt eget. Phasellus finibus elementum
  scelerisque.
EOF
  expected_show_comments = <<-EOF
Doc
  Suspendisse id lacus faucibus, luctus nibh non, tincidunt orci.
  Etiam vehicula ex ullamcorper ligula euismod, vitae lacinia quam
  faucibus. Quisque faucibus leo commodo mauris vulputate, sodales
  euismod lectus semper.
Params
  id: integer
  additional
    likes_cookies: boolean
    likes_top_gear: boolean
    languages: string (coma separated list)
EOF
  expected_new_comments = <<-EOF

EOF
  expected_create_comments = <<-EOF
Doc
  Praesent maximus, leo a maximus fringilla, urna felis sollicitudin
  nunc, eu pulvinar est urna eu justo. Phasellus quis hendrerit nibh.
  Praesent id nunc ac augue ultricies rutrum at vel quam.
GET
  Params
    id: integer
POST
  Params
    id:   integer
    age:  integer
    additional
      likes_cookies: boolean
      likes_top_gear: boolean
      language
        name: string
        level_of_knowlage: string (A1, A2, B1, B2, C1, C2)
    name: string
EOF
  expected_edit_comments = <<-EOF
Url
  /api/v1/person/{test_id}
EOF
  expected_update_comments = <<-EOF
PUT
  Doc
    Praesent maximus, leo a maximus fringilla, urna felis sollicitudin
    nunc, eu pulvinar est urna eu justo. Phasellus quis hendrerit nibh.
    Praesent id nunc ac augue ultricies rutrum at vel quam.
  Params
    id: integer
PATCH
  Doc
    Phasellus ac diam sit amet elit cursus tincidunt. Donec vel
    tincidunt orci. Maecenas in feugiat tortor. Lorem ipsum dolor sit
    amet, consectetur adipiscing elit.
  Params
    id:   integer
    age:  integer
    name: string
EOF
  expected_destroy_comments = <<-EOF
Something complete unrelated to the toppic of documentation generation
but it's here just to confuse the parser and shour be ignorred by it
hopefully... You newer know what those parsers are going to do...
EOF

  describe '#method_comments' do
    it 'returns a hash of method names with their comments' do
      file_path = Interdasting::Router.api_controller_paths.first
      comments = Interdasting::Parser.method_comments(file_path)
      expected_comments = {
        'index'   => expected_index_comments,
        'show'    => expected_show_comments,
        'new'     => expected_new_comments,
        'create'  => expected_create_comments,
        'edit'    => expected_edit_comments,
        'update'  => expected_update_comments,
        'destroy' => expected_destroy_comments
      }
      expect(comments).to be_a Hash
      expect(comments).to eq expected_comments
    end
  end

  describe '#comments_for_method' do
    it 'returns the comments before a method' do
      file_path = Interdasting::Router.api_controller_paths.first
      comments = Interdasting::Parser.comments_for_method('index', file_path)
      expect(comments).to be_a String
      expect(comments).to eq expected_index_comments
    end
  end

  describe '#parse_comments' do
    it 'returns a hash containing the values of the comments' do
      comments = Interdasting::Parser.parse_comments(expected_create_comments)
      expect(comments).to be_a IndentationParser::RootNode
      comments = comments.value
      expect(comments).to be_a Hash
      expect(comments).to eq(
        'DOC' => 'Praesent maximus, leo a maximus fringilla, urna felis '\
                 'sollicitudin nunc, eu pulvinar est urna eu justo. Phasellus '\
                 'quis hendrerit nibh. Praesent id nunc ac augue ultricies '\
                 'rutrum at vel quam.',
        'GET' => {
          'PARAMS' => {
            'id' => 'integer'
          }
        },
        'POST' => {
          'PARAMS' => {
            'id' => 'integer',
            'age' => 'integer',
            'additional' => {
              'likes_cookies' => 'boolean',
              'likes_top_gear' => 'boolean',
              'language' => {
                'name' => 'string',
                'level_of_knowlage' => 'string (A1, A2, B1, B2, C1, C2)'
              }
            },
            'name' => 'string'
          }
        }
      )
    end
  end
end
