class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
    respond_to do |f| 
      f.html
      f.json { render json: { adventures: @adventures.where(library_id: nil).as_json(only: [:title, :author, :updated_at, :guid],
                      include: {:pages => {except: [:adventure_id, :id, :created_at, :updated_at]} } ) } } 
    end
  end

  def show
    binding.pry
    @adventure = Adventure.find(id)
    respond_to do |f|
      f.html
      f.json { render json: @adventure.as_json(except: [:created_at]) }
    end
  end

  def new
    @adventure = Adventure.new
    respond_to do |f|
      f.html
      f.json { render json: {} }
    end
  end

  def create
    @adventure = Adventure.create(adventure_params)
    respond_to do |f|
      f.html
      f.json { render json: @adventure.as_json}
    end
  end

  def edit
  end

  private

    def adventure_params
      params.require(:adventure).permit(:title, :author)
    end

    def id
      params[:id]
    end

end
