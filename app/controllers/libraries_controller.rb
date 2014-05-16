class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    respond_to do |f| 
      f.html
      f.json { render json: { libraries: @libraries }  }  
    end
  end

  def show
    @library = Library.find(id)
    respond_to do |f|
      f.html
      f.json { render json:  @library.as_json }
    end
  end

  def new
    @library = Library.new
    respond_to do |f|
      f.html
      f.json { render json: {} }
    end

  end

  private

    def id
      params[:id]
    end

end
