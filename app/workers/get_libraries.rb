class GetLibraries
  
  include Sidekiq::Worker

  def perform(url)
    # perform kicks off the first scrape
    scrape(url)    
  end

  def scrape(url)
    # 'adventures-with-raphael.herokuapp.com/libraries.json'
    response = Typhoeus.get(url)
    # response = Typhoeus.get(url)
    if response.response_code == 200 
      links = JSON.parse(response.body)["libraries"]
      links.each do |link|
        if Typhoeus.get(link["url"] + "libraries.json").response_code == 200
          # Library.create(link)
          # only create the library if the library does not exist
          Library.create(url: link["url"]) if !Library.find_by_url(link["url"])
          # recursively scrape all the libraries
          # scrape(url) 
        end
      end
      
    end
  end

end