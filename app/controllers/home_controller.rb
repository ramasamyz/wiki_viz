class HomeController < ApplicationController
  def index
  end

  def display
    wiki_page = Wiki.new(params[:page],rvparse: 1)
    @table = wiki_page.parse_table
  end
end
