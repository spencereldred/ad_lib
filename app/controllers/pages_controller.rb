class PagesController < ApplicationController
  def index

  end

  def show
    # binding.pry
    @adventure = Adventure.find(params[:adventure_id])
    @page = @adventure.pages.find(params[:id])
    respond_to do |f|
      f.html
      f.json { render json: @page }
    end
  end

  def edit
  end

  def new
  end
end
