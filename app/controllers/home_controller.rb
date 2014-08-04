class HomeController < ApplicationController
  def index
  end

  def display
    flash[:notice] = "" 
    wiki_page = Wiki.new(params[:page],rvparse: 1)
    @tables = wiki_page.parse_table
    if @tables.empty?
      flash[:notice] = "No Table was parsed for page: #{params[:page]}"
      render 'index'
    end
  end
end
