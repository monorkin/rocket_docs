module Interdasting
  class ApplicationController < ActionController::Base
    def index
      @docs = Interdasting.documentation
      render 'docs/interdasting/index'
    end

    def show
      @doc = Interdasting.documentation_for_version(params[:version])
      render 'docs/interdasting/show'
    end
  end
end
