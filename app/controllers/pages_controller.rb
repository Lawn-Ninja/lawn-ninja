class PagesController < ApplicationController
  def index
    p "*" * 50
  end

  def show
    render 'landing-page-not-logged.html'
  end
end
