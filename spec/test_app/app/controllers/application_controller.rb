class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render 'static/hello'
  end
end
