class PagesController < ApplicationController
  def index

  end

  def show
    @adventure = Adventure.find(params[:adventure_id])
    @page = @adventure.pages.find_by_name(:start)
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
