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
      id: integer
     age: integer
    name: string
EOF
  expected_update_comments = <<-EOF
GET
  Doc
    Praesent maximus, leo a maximus fringilla, urna felis sollicitudin
    nunc, eu pulvinar est urna eu justo. Phasellus quis hendrerit nibh.
    Praesent id nunc ac augue ultricies rutrum at vel quam.
  Params
    id: integer
POST
  Doc
    Phasellus ac diam sit amet elit cursus tincidunt. Donec vel
    tincidunt orci. Maecenas in feugiat tortor. Lorem ipsum dolor sit
    amet, consectetur adipiscing elit.
  Params
      id: integer
     age: integer
    name: string
EOF
  expected_destroy_comments = <<-EOF
Something complete unrelated to the toppic of documentation generation
but it's here just to confuse the parser and shour be ignorred by it
hopefully... You newer know what those parsers are going to do...
EOF

  describe '#method_comments' do
    it 'returns a hash of methodnames with their comments' do
      file_path = Interdasting::Router.api_controller_paths.first
      comments = Interdasting::Parser.method_comments(file_path)
      expected_comments = {
        'index'   => expected_index_comments,
        'show'    => expected_show_comments,
        'create'  => expected_create_comments,
        'update'  => expected_update_comments,
        'destroy' => expected_destroy_comments
      }
      expect(comments).to be_a Hash
      expect(comments).to eq expected_comments
    end
  end

  describe '#method_comments' do
    it 'returns a hash of methodnames with their comments' do
      file_path = Interdasting::Router.api_controller_paths.first
      comments = Interdasting::Parser.comments_for_method('index', file_path)
      expect(comments).to be_a String
      expect(comments).to eq expected_index_comments
    end
  end
end
