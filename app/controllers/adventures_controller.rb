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

  def scrape(url)
    # adventures-with-raphael.herokuapp.com/
    response = Typhoeus.get('adventures-with-raphael.herokuapp.com/libraries.json')
    # response = Typhoeus.get(url)
    if response.response_code == 200 
      links = JSON.parse(response.body)["libraries"]
      links.each do |link|
        if Typhoeus.get(link["url"] + "libraries.json").response_code == 200
          Library.create(link)
          # Library.create(url: link["url"]) if !Library.find_by_url(link["url"])
          scrape(url) 
        end
      end
    end
  end

  # Spencers-MacBook-Pro-2:adventure_library Spencer$ rails s --binding=10.6.6.218
  # => Booting WEBrick
  # => Rails 4.0.2 application starting in development on http://10.6.6.218:3000
  # => Run `rails server -h` for more startup options
  # => Ctrl-C to shutdown server
  # [2014-05-16 17:10:09] INFO  WEBrick 1.3.1
  # [2014-05-16 17:10:09] INFO  ruby 2.1.1 (2014-02-24) [x86_64-darwin12.0]
  # [2014-05-16 17:10:09] INFO  WEBrick::HTTPServer#start: pid=3431 port=3000


  def get_adventures
    libraries = Library.all
    libraries.each do |library|
      response = Typhoeus.get(library['url'] + "/adventures.json")
      adventures = JSON.parse(response.body)
      # title:  adventures[0]['title']
      # author: adventures[0]['author']
      # updated_at: adventures[0]['updated_at']
      # guid: adventures[0]['guid']
      # adventure pages array: adventures[0]['pages']

      # TODO: to be tested 
      adventures['adventures'].each do |a|
        adventure = Adventure.create(title: a['title'], author: a['author'], guid: a['guid'], library_id: a['library_id'])
        a['pages'].each do |p|
          adventure.pages.create(name: p['name'], text: p['text'])
        end
      end
      # Test results
      # [29] pry(main)> adventures['adventures'].each do |a|
      # [29] pry(main)*   puts "Title: #{a['title']}, Author: #{a['author']}, guid: #{a['guid']}, Library_id: #{a['library_id']}"  
      # [29] pry(main)* end  
      # Title: rat chaos, Author: Kat Lake, guid: F1LXUOQamJO7cQ, Library_id: 
      # Title: Raphael Sofaer's Test Adventure, Author: Raphael Sofaer, guid: h5iM2Fs8QS6lWA, Library_id: 
      # => [{"title"=>"rat chaos",
      #   "author"=>"Kat Lake",
      #   "created_at"=>"2014-02-17T06:16:48.794Z",
      #   "updated_at"=>"2014-02-17T06:16:48.794Z",
      #   "guid"=>"F1LXUOQamJO7cQ",
      #   "pages"=>
      # [32] pry(main)> adventures['adventures'].each do |a|
      # [32] pry(main)*   puts "Title: #{a['title']}, Author: #{a['author']}, guid: #{a['guid']}, Library_id: #{a['library_id']}"  
      # [32] pry(main)*   a['pages'].each do |p|  
      # [32] pry(main)*     puts "Name: #{p['name']}, Text: #{p['text']}"    
      # [32] pry(main)*   end  
      # [32] pry(main)* end  
      # Title: rat chaos, Author: Kat Lake, guid: F1LXUOQamJO7cQ, Library_id: 
      # Name: StoryAuthor, Text: j chastain
      # Name: planetofrat, Text: New Rat City needs a lot of love. Help New Rat City with his needs.<br><br><br><br>"I'm getting lots of exercise."<br>"I would like you to construct a large, pink cube."<br>"I feel fucking miserable."<br><br>[[Feed NRC a pellet|rata1]]<br>[[Construct large, pink cube|rata2]]<br>[["Do you need to talk?"|rata3]]<br>
      # Name: ruin, Text: <br><br>YOU'VE RUINED EVERYTHING



    end
    
  end

  private

    def adventure_params
      params.require(:adventure).permit(:title, :author)
    end

    def id
      params[:id]
    end

end
