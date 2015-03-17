module RocketDocs
  class ApplicationController < ActionController::Base
    def index
      @docs = RocketDocs.documentation
      render 'docs/rocket_docs/index'
    end

    def show
      @doc = RocketDocs.documentation_for_version(params[:version])
      render 'docs/rocket_docs/show'
    end
  end
end
