module Api
  module V1
    class PeopleController < ApiController
      # Doc
      #   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
      #   gravida convallis aliquam. Duis pellentesque bibendum ipsum, vel
      #   imperdiet metus tincidunt eget. Phasellus finibus elementum
      #   scelerisque.
      #
      def index
        puts 'Oh really?' if (true != false) # inline coments should be ignored
        exposes (0...1500).to_a.map do |_i|
          fake_name = (0...8).map { (65 + rand(26)).chr }.join
          { name: fake_name }
        end
      end

      # Doc
      #   Suspendisse id lacus faucibus, luctus nibh non, tincidunt orci.
      #   Etiam vehicula ex ullamcorper ligula euismod, vitae lacinia quam
      #   faucibus. Quisque faucibus leo commodo mauris vulputate, sodales
      #   euismod lectus semper.
      # Params
      #   id: integer
      #   additional
      #     likes_cookies: boolean
      #     likes_top_gear: boolean
      #     languages: string (coma separated list)
      #
      def show
        # Let's see if this will get picked up by the parser
        puts 'I am blind!!!'
        fake_object = (0...10).to_a.map do |_i|
          k = (0...8).map { (65 + rand(26)).chr }.join
          v = (0...8).map { (65 + rand(26)).chr }.join.downcase
          [k, v]
        end
        exposes Hash[fake_object].merge(id: params[:id])
      end

      def new
        exposes {}
      end

      #
      # Doc
      #   Praesent maximus, leo a maximus fringilla, urna felis sollicitudin
      #   nunc, eu pulvinar est urna eu justo. Phasellus quis hendrerit nibh.
      #   Praesent id nunc ac augue ultricies rutrum at vel quam.
      # GET
      #   Params
      #     id: integer
      # POST
      #   Params
      #     id:   integer
      #     age:  integer
      #     additional
      #       likes_cookies: boolean
      #       likes_top_gear: boolean
      #       language
      #         name: string
      #         level_of_knowlage: string (A1, A2, B1, B2, C1, C2)
      #     name: string
      #

      def create
        puts 'Assembling...'
        exposes {}
      end

      # Url
      #   /api/v1/person/{test_id}
      def edit
        exposes(test_id: params[:test_id])
      end

      # PUT
      #   Doc
      #     Praesent maximus, leo a maximus fringilla, urna felis sollicitudin
      #     nunc, eu pulvinar est urna eu justo. Phasellus quis hendrerit nibh.
      #     Praesent id nunc ac augue ultricies rutrum at vel quam.
      #   Params
      #     id: integer
      # PATCH
      #   Doc
      #     Phasellus ac diam sit amet elit cursus tincidunt. Donec vel
      #     tincidunt orci. Maecenas in feugiat tortor. Lorem ipsum dolor sit
      #     amet, consectetur adipiscing elit.
      #   Params
      #     id:   integer
      #     age:  integer
      #     name: string

      def update
        puts 'Why would you waont to change things?'
        exposes params
      end

      # Something complete unrelated to the toppic of documentation generation
      # but it's here just to confuse the parser and shour be ignorred by it
      # hopefully... You newer know what those parsers are going to do...
      def destroy
        puts 'Bang! Bang! You shoot me down. Bang! Bang! I hit the ground...'
        exposes params
      end
    end
  end
end
