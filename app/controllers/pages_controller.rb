class PagesController < ApplicationController
  def index
    p "*" * 50
  end

  def show
    render 'landing_page_not_logged.html'
  end
end
