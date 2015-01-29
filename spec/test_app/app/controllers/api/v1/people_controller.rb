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
        render json: params
      end

      # Doc
      #   Suspendisse id lacus faucibus, luctus nibh non, tincidunt orci.
      #   Etiam vehicula ex ullamcorper ligula euismod, vitae lacinia quam
      #   faucibus. Quisque faucibus leo commodo mauris vulputate, sodales
      #   euismod lectus semper.
      # Params
      #   id: integer
      #
      def show
        # Let's see if this will get picked up by the parser
        puts 'I am blind!!!'
        render json: params
      end

      def new
        render json: params
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
      #     name: string

      def create
        puts 'Assembling...'
        puts '* Pouring hot coco'
        sleep 1
        puts '* Inventing stupid loading text'
        sleep 1
        puts '* Actually going to work'
        sleep 1
        puts '* Cutting ruby'
        puts 'Done!'
        render json: params
      end

      # Url
      #   /api/v1/person/:test_id
      def edit
        render json: params
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
        render json: params
      end

      # Something complete unrelated to the toppic of documentation generation
      # but it's here just to confuse the parser and shour be ignorred by it
      # hopefully... You newer know what those parsers are going to do...
      def destroy
        puts 'Bang! Bang! You shoot me down. Bang! Bang! I hit the ground...'
        render json: params
      end
    end
  end
end
